---
title: "Docker コーディング規約 ベストプラクティス"
description: "Dockerのベストプラクティスについてまとめたよ！これを参考に、もっと効率的で安全なDockerイメージを作れるようになるはずだよ！🚀"
author: "Reco"
version: "1.0"
date: "2025-06-03"
tags: ["Docker", "ベストプラクティス", "コンテナ", "Dockerfile", "CI/CD", "docker", "best-practices", "container", "coding-standards", "コーディング規約"]
globs: ["*"]
---

# Docker Coding Standards Best Practices ✨

Here's a compilation of Docker best practices! Use this reference to create more efficient and secure Docker images! 🚀

## 1. Utilize Multi-stage Builds! 🏗️
To reduce the final image size, divide the build process into multiple stages. This way, the final image will only contain files necessary for running the application. You can also run build steps in parallel, improving efficiency!

### Create Reusable Stages! ♻️
If you have multiple images with common components, create reusable stages that combine them and use those as a base. Docker only needs to build common stages once, improving memory efficiency and faster loading.

## 2. Choose Appropriate Base Images! 💡
The first step to creating secure images is choosing the right base image. The key is to select images built from trusted sources that are as small as possible!

*   **Docker Official Images**: These have solid documentation, promote best practices, and are regularly updated, making them a reliable starting point for many applications.
*   **Verified Publisher Images**: High-quality images published and maintained by organizations partnered with Docker. Docker verifies the reliability of their content.
*   **Docker-Sponsored Open Source Images**: Images published and maintained by projects supported by Docker through their open source program.

Choosing images with badges from these programs gives you peace of mind!

When building images from Dockerfile yourself, choose minimal base images that meet your requirements. Small images are not only more portable and download faster, but also reduce image size and minimize the number of vulnerabilities from dependencies.

Consider using two types of base images: one for builds and unit tests, and another for production (usually a slimmer image). In later development stages, build tools like compilers, build systems, and debugging tools are often unnecessary, so small images with minimal dependencies significantly reduce the attack surface.

## 3. Rebuild Images Regularly! 🔄
Docker images are immutable. Building an image means taking a snapshot at that moment. This includes the base image, libraries, and other software. To keep the image up-to-date and secure, update dependencies and rebuild the image frequently.

To ensure you get the latest version of dependencies at build time, you can avoid cache hits by using the `--no-cache` option.

```console
$ docker build --no-cache -t my-image:my-tag .
```

Consider fixing the base image version as well.

## 4. Use `.dockerignore` to Exclude Files! 🗑️
To exclude files that are not related to the build without rebuilding the source repository, use the `.dockerignore` file. This file supports the same exclusion patterns as the `.gitignore` file.

For example, to exclude all files with the `.md` extension, write the following:

```plaintext
*.md
```

## 5. Create Ephemeral Containers! 👻
To create an image defined in Dockerfile, try to generate ephemeral (temporary) containers as much as possible. Ephemeral means that the container can be stopped and discarded, and the setup and configuration can be rebuilt and replaced with a minimum setup.

For the motivation to run containers in a stateless way, refer to "Process" in The Twelve-factor App.

## 6. Avoid Installing Unnecessary Packages! 🚫
Avoid installing unnecessary packages just because they might be useful. For example, a database image does not need to include a text editor.

By not installing unnecessary packages, the image becomes simpler, the dependencies are reduced, the file size is reduced, and the build time is shortened.

## 7. Separate Applications! 🔗
Each container should have only one role. By separating the application into multiple containers, horizontal scaling becomes easier, and containers can be reused more easily. For example, a web application stack can consist of three independent containers, each managing its own image: the web application, the database, and an in-memory cache.

Limiting each container to one process is a good guideline, but it is not a strict rule. For example, containers can be started with an init process, and some programs may also start their own processes.

To keep the container as clean and modular as possible, make the best judgment. If the containers depend on each other, use Docker container networks to ensure they can communicate.

## 8. Sort Multiple Line Arguments! 🔠
If possible, sort multiple line arguments alphabetically to make maintenance easier. This avoids package duplication and makes updating the list much easier. It also makes PRs easier to read and review. Adding a space before the backslash (`\`) is also effective.

## 9. Use the Build Cache! ⚡
When building an image, Docker executes the instructions in the Dockerfile in order. For each instruction, Docker checks if it can reuse the instruction from the build cache.

Understanding how the build cache works and how to disable it is very important for speeding up the build.

## 10. Fix the Base Image Version! 🔒
The image tag can be changed, and the publisher can update the tag to point to a new image. This is convenient because the publisher can update the tag to point to a new version of the image. As a user of the image, you can automatically get the latest version of the image every time you rebuild it.

For example, if you specify `FROM alpine:3.21` in the Dockerfile, `3.21` will be resolved to the latest patch version of `3.21`.

```dockerfile
# syntax=docker/dockerfile:1
FROM alpine:3.21
```

However, there is a drawback to this. There is no guarantee that the same image will be obtained for each build. This means that there is a possibility of a breaking change, and there is no audit trail of the exact image version being used.

To ensure complete supply chain integrity, you can fix the image version to a specific digest. By fixing the image to a digest, it is guaranteed that the same image version will be used even if the publisher replaces the tag with a new image.

```dockerfile
# syntax=docker/dockerfile:1
FROM alpine:3.21@sha256:a8560b36e8b8210634f77d9f7f9efd7ffa463e380b75e2e74aff4511df3ef88c
```

This way, you can avoid unexpected changes, but manually checking the image digest and including it is time-consuming, and you may not be able to receive automated security fixes.

Docker Scout's default "Up-to-Date Base Images" policy checks if the version of the base image you are using is actually the latest version. This policy also checks if the fixed digest in the Dockerfile corresponds to the correct version. If the publisher updates the fixed image, the policy evaluation returns a non-compliant status, indicating that the image needs to be updated.

Docker Scout also supports an automatic repair workflow for automatically updating base images in Docker Scout. When a new image digest becomes available, Docker Scout automatically creates a pull request in the repository to update the Dockerfile to the latest version. This is better than using a tag that automatically changes the version, because there is an audit trail of when and how the change was made, and Jun can control it.

## 11. Build Images in CI and Test Them! ✅
When committing changes to source control or creating pull requests, use GitHub Actions or other CI/CD pipelines to automatically build and tag Docker images.

## 12. Dockerfile Instructions 📝

### FROM
If possible, use the current official image as a base. Docker recommends Alpine images. This is a fully managed Linux distribution that is small (currently less than 6MB) and has a strict size limit.

### LABEL
You can add labels to the image to organize images by project, record license information, and support automation. Add a line starting with `LABEL` that has one or more key-value pairs for each label.

### RUN
Long and complex `RUN` statements are easier to read, understand, and maintain if you split them into multiple lines using a backslash.

When using `apt-get`, always combine `RUN apt-get update` and `apt-get install` into the same `RUN` statement. This prevents cache issues and ensures that the latest package version is installed.

When using pipes, add `set -o pipefail &&` at the beginning to ensure that the command fails if an error occurs at any stage in the pipe.

### CMD
`CMD` should be used to run software included in the image with arguments. In most cases, it should be used in the form of `CMD ["executable", "param1", "param2"]`.

### EXPOSE
`EXPOSE` should be used to indicate the port the container listens for connections. Use the general port of the application.

### ENV
`ENV` can be used to update the `PATH` environment variable for software installed by the container, making it easier to run new software. It is also useful for providing service-specific environment variables and managing version numbers.

To completely unset the environment variable, run `export`, `echo`, and `unset` in one `RUN` command layer.

### ADD or COPY
`ADD` and `COPY` are functionally similar, but in most cases, it is recommended to use `COPY`. `COPY` is suitable for copying files from the build context to the container.

`ADD` is best when you need to download remote artifacts as part of the build. It provides more accurate build caching compared to manually adding files with `wget` or `tar`.

### ENTRYPOINT
The best way to use `ENTRYPOINT` is to set the main command of the image. This allows the image to be executed as if it were that command, and `CMD` can be used as a default flag.

### VOLUME
`VOLUME` should be used to expose the storage area of the database, configuration storage, or files and folders created by the Docker container. It is strongly recommended to use `VOLUME` for any part of the image that can be changed or is user-serviceable.

### USER
If the service can be run without privileges, use `USER` to change to a non-root user. Start by creating a user and group in the Dockerfile.

Avoid installing and using `sudo`. There are unpredictable TTY and signal forwarding behaviors that can cause problems.

### WORKDIR
For clarity and reliability, always use an absolute path for `WORKDIR`. Instead of adding commands like `RUN cd … && do-something` that are difficult to read and troubleshoot, use `WORKDIR`.

### ONBUILD
The `ONBUILD` command is executed after the current Dockerfile build is complete. `ONBUILD` is executed in the child image derived from the current image. Think of the `ONBUILD` command as instructions given by the parent Dockerfile to the child Dockerfile.

It is recommended to give a different tag to the image built with `ONBUILD`. For example, `ruby:1.9-onbuild` or `ruby:2.0-onbuild`.

This way, Docker's best practices are perfect! Do you have any questions? 😊

### 13. Debug HTTP Errors in Containers! 🐛
When you get `404 Not Found` or `500 Internal Server Error`, don't panic! Check here first!

1.  **First, check the logs!**
    - Use `docker-compose logs (service name)` to find out what's happening.
2.  **Check the Web Server Configuration!**
    - Check `apache2.conf` or `.conf` files for Apache, or `nginx.conf` for Nginx, and verify that the `DocumentRoot` and virtual host settings are correct!
3.  **Check `.htaccess`!**
    - Check if `RewriteRule` or `Action` directives are causing unintended behavior. It is recommended to comment out suspicious parts and isolate them first!
4.  **Check Permissions!**
    - Especially when mounting volumes, check if the executing user (`www-data` etc.) in the container can access the files. `docker-compose exec (service name) ls -l (path)` is useful.
5.  **Look outside from the container!**
    - Check if the container can access the outside world. `docker-compose exec (service name) curl http://example.com` is useful. It may also reveal DNS issues.
