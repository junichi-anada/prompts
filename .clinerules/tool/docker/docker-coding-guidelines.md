---
title: "Docker Coding Guidelines Best Practices"
description: "Best practices for Docker summarized! Use this reference to create more efficient and secure Docker images! 🚀"
author: "Reco"
version: "1.0"
date: "2025-06-03"
tags: ["Docker", "best-practices", "ベストプラクティス", "container", "コンテナ", "Dockerfile", "CI/CD"]
globs: ["*"]
---

# Docker Coding Guidelines Best Practices ✨

Jun, I've summarized Docker best practices! Use this reference to create more efficient and secure Docker images! 🚀

## 1. Utilize Multi-Stage Builds! 🏗️
Split your build process into multiple stages to reduce the final image size. This way, the final image will only contain files necessary for running the application. Build steps can run in parallel, improving efficiency!

### Create Reusable Stages! ♻️
If you have multiple images with common components, create reusable stages that combine them as a base. Docker only needs to build common stages once, improving memory efficiency and faster loading.

## 2. Choose the Right Base Image! 💡
The first step to creating secure images is choosing the right base image. The key is selecting images built from trusted sources and keeping them as small as possible!

*   **Docker Official Images**: Well-documented, promote best practices, and regularly updated, making them reliable starting points for many applications.
*   **Verified Publisher Images**: High-quality images published and maintained by organizations partnered with Docker. Docker verifies the content's reliability.
*   **Docker-Sponsored Open Source Images**: Images published and maintained by projects supported by Docker through their open source program.

Choosing images with these program badges gives you peace of mind!

When building images from Dockerfiles yourself, choose minimal base images that meet your requirements. Smaller images are not only more portable and faster to download, but they also reduce image size and minimize the number of vulnerabilities from dependencies.

Consider using two types of base images: one for builds and unit tests, and another for production (usually slimmer images). In later development stages, build tools like compilers, build systems, and debug tools are often unnecessary, so smaller images with minimal dependencies significantly reduce the attack surface.

## 3. Rebuild Images Frequently! 🔄
Docker images are immutable. Building an image means taking a snapshot at that point in time. This includes base images, libraries, and other software. To keep images up-to-date and secure, update dependencies and rebuild images frequently.

To ensure you get the latest versions of dependencies during builds, you can use the `--no-cache` option to avoid cache hits.

```console
$ docker build --no-cache -t my-image:my-tag .
```

Consider pinning your base image versions as well.

## 4. Exclude with `.dockerignore`! 🗑️
To exclude files unrelated to builds without rebuilding the source repository, use a `.dockerignore` file. This file supports exclusion patterns similar to `.gitignore` files.

For example, to exclude all files with `.md` extensions, write:

```plaintext
*.md
```

## 5. Create Ephemeral Containers! 👻
Images defined in Dockerfiles should generate ephemeral (temporary) containers as much as possible. Ephemeral means that even if you stop and destroy containers, they can be rebuilt and replaced with minimal setup and configuration.

For motivation on running containers in a stateless manner, refer to "Processes" in The Twelve-Factor App.

## 6. Don't Install Unnecessary Packages! 🚫
Avoid installing extra or unnecessary packages just because they "might be useful." For example, there's no need to include a text editor in a database image.

By not installing extra or unnecessary packages, you reduce image complexity, dependencies, file size, and build time.

## 7. Decouple Applications! 🔗
Each container should have only one concern. Decoupling applications into multiple containers makes horizontal scaling easier and container reuse more convenient. For example, a web application stack can consist of three separate containers with their own images to manage the web application, database, and in-memory cache respectively.

Limiting each container to one process is a good rule of thumb, but not a hard rule. For example, containers can spawn with init processes, and some programs may spawn their own processes.

Use your best judgment to keep containers as clean and modular as possible. If containers depend on each other, use Docker container networks to enable communication between these containers.

## 8. Sort Multi-line Arguments! 🔠
Whenever possible, sort multi-line arguments alphabetically to make maintenance easier. This helps avoid package duplication and makes updating lists much simpler. It also makes PRs easier to read and review. Adding a space before backslashes (`\`) is also effective.

## 9. Leverage Build Cache! ⚡
When building images, Docker steps through Dockerfile instructions in order. For each instruction, Docker checks whether it can reuse that instruction from the build cache.

Understanding how the build cache works and how cache invalidation occurs is crucial for speeding up builds.

## 10. Pin Base Image Versions! 🔒
Image tags are mutable, and publishers can update tags to point to new images. This is convenient as publishers can update tags to point to new versions of images, and as image consumers, you automatically get new versions every time you rebuild images.

For example, when you specify `FROM alpine:3.21` in a Dockerfile, `3.21` resolves to the latest patch version of `3.21`.

```dockerfile
# syntax=docker/dockerfile:1
FROM alpine:3.21
```

However, this has drawbacks. There's no guarantee you'll get the same thing on every build. This can introduce breaking changes and leaves no audit trail of the exact image versions you're using.

For complete supply chain integrity, you can pin image versions to specific digests. Pinning images to digests ensures you always use the same image version, even if publishers replace tags with new images.

```dockerfile
# syntax=docker/dockerfile:1
FROM alpine:3.21@sha256:a8560b36e8b8210634f77d9f7f9efd7ffa463e380b75e2e74aff4511df3ef88c
```

This avoids unexpected changes, but manually looking up and including image digests is tedious and may prevent you from receiving automated security fixes.

Docker Scout's default "Up-to-Date Base Images" policy checks whether the base image versions you're using are actually the latest versions. This policy also checks whether pinned digests in Dockerfiles correspond to the correct versions. If publishers update pinned images, policy evaluation returns a non-compliant status, indicating you need to update your images.

Docker Scout also supports auto-remediation workflows for automatically updating base images with Docker Scout. When new image digests become available, Docker Scout can automatically create pull requests in your repository to update Dockerfiles to the latest versions. This is better than using tags that automatically change versions because there's an audit trail of when and how changes were made, and Jun has control.

## 11. Build and Test Images in CI! ✅
When committing changes to source control or creating pull requests, use GitHub Actions or other CI/CD pipelines to automatically build, tag, and test Docker images.

## 12. About Dockerfile Instructions 📝

### FROM
Whenever possible, use current official images as your base. Docker recommends Alpine images since they're strictly controlled and small in size (currently under 6MB) while being a complete Linux distribution.

### LABEL
You can add labels to images to organize images by project, record licensing information, or aid automation. Add a line beginning with `LABEL` for each label, containing one or more key-value pairs.

### RUN
Long or complex `RUN` statements should be split across multiple lines separated with backslashes to make your Dockerfile more readable, understandable, and maintainable.

When using `apt-get`, always combine `RUN apt-get update` with `apt-get install` in the same `RUN` statement. This prevents caching issues and ensures the latest package versions are always installed.

When using pipes, add `set -o pipefail &&` at the beginning to ensure commands fail if any stage in the pipe encounters an error.

### CMD
The `CMD` instruction should be used to run the software contained by your image, along with any arguments. In most cases, you should use the form `CMD ["executable", "param1", "param2"]`.

### EXPOSE
The `EXPOSE` instruction indicates the ports on which a container listens for connections. You should use the common port for your application.

### ENV
To make new software easier to run, you can use `ENV` to update the `PATH` environment variable for the software your container installs. It's also useful for providing service-specific environment variables or managing version numbers.

To completely unset environment variables, use a `RUN` command with `export`, `echo`, and `unset` in a single layer.

### ADD or COPY
Although `ADD` and `COPY` are functionally similar, generally speaking, `COPY` is preferred. `COPY` is appropriate for copying files from build context to containers.

`ADD` is best for when you need to download remote artifacts as part of builds. It provides more precise build cache guarantees than manually adding files with `wget` or `tar`.

### ENTRYPOINT
The best use for `ENTRYPOINT` is to set the image's main command, allowing that image to be run as though it was that command, using `CMD` as default flags.

### VOLUME
The `VOLUME` instruction should be used to expose database storage areas, configuration storage, or files/folders created by your Docker container. You're strongly encouraged to use `VOLUME` for any mutable and/or user-serviceable parts of your image.

### USER
If a service can run without privileges, use `USER` to change to a non-root user. Start by creating the user and group in the Dockerfile.

Avoid installing or using `sudo` as it has unpredictable TTY and signal-forwarding behavior that can cause problems.

### WORKDIR
For clarity and reliability, you should always use absolute paths for your `WORKDIR`. Instead of proliferating instructions like `RUN cd … && do-something`, which are hard to read, troubleshoot, and maintain, use `WORKDIR`.

### ONBUILD
An `ONBUILD` command executes after the current Dockerfile build completes. `ONBUILD` executes in any child image derived from the current image. Think of the `ONBUILD` command as an instruction the parent Dockerfile gives to the child Dockerfile.

Images built with `ONBUILD` should get a separate tag, for example: `ruby:1.9-onbuild` or `ruby:2.0-onbuild`.

That covers Docker best practices perfectly! Do you have any questions? 😊
