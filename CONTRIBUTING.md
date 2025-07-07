# Contributing to prompts (Custom .clinerules Repository)

Thank you for your interest in contributing to this repository! This is a fork of `cline/prompts` that serves as a centralized source for custom `.clinerules` files. This guide will help you understand how to contribute effectively.

## 🌟 Welcome / ようこそ

This repository maintains AI assistant behavioral rules that can be selectively copied to other projects. We welcome contributions in both English and Japanese.

**Important**: All custom rules and contributions should target the `my-rules` branch, NOT `main`. The `main` branch is reserved for syncing with the upstream repository.

## 📋 Table of Contents

- [Getting Started](#getting-started)
- [Types of Contributions](#types-of-contributions)
- [Language Guidelines](#language-guidelines)
- [Creating New Rules](#creating-new-rules)
- [Updating Existing Rules](#updating-existing-rules)
- [Testing Your Changes](#testing-your-changes)
- [Submitting Changes](#submitting-changes)
- [Code of Conduct](#code-of-conduct)

## 🚀 Getting Started

### Prerequisites

- Git and GitHub account
- Basic understanding of Markdown
- Familiarity with YAML frontmatter
- Understanding of AI assistant behaviors (Cline/Claude)

### Initial Setup

1. **Fork the repository**
   ```bash
   # Fork via GitHub UI, then clone your fork
   git clone https://github.com/YOUR_USERNAME/prompts.git
   cd prompts
   ```

2. **Add upstream remote**
   ```bash
   git remote add upstream https://github.com/cline/prompts.git
   ```

3. **Switch to my-rules branch**
   ```bash
   git checkout my-rules
   ```

4. **Keep your fork updated**
   ```bash
   git checkout main
   git fetch upstream
   git merge upstream/main
   git checkout my-rules
   git merge main  # If needed
   ```

## 🤝 Types of Contributions

We welcome the following types of contributions:

### 1. **New Rules** 📝
Create new `.clinerules` files for specific use cases:
- Programming language guidelines
- Framework-specific patterns
- Tool configurations
- Workflow definitions
- Role-based behaviors

### 2. **Rule Updates** 🔄
Improve existing rules:
- Fix errors or outdated information
- Add new examples
- Improve clarity
- Update for new tool/framework versions

### 3. **Translations** 🌐
- Translate rules between Japanese and English
- Ensure technical accuracy in both languages
- Add bilingual tags

### 4. **Documentation** 📚
- Improve README files
- Update CLAUDE.md
- Enhance meta-documentation
- Add examples and tutorials

### 5. **Automation & Tools** 🔧
- Improve validation scripts
- Add new utility scripts
- Enhance CI/CD workflows

## 🗣️ Language Guidelines

This project supports both English and Japanese. Here's when to use each:

### Use English for:
- Technical rules in `core-behavior/`, `coding/`, `tool/` directories
- Code comments and examples
- Git commit messages for technical changes
- API and function names

### Use Japanese for:
- Workflow documentation in `workflows/` directory
- Conceptual explanations
- Community discussions
- Git commit messages for Japanese documentation

### Bilingual Requirements:
- Tags should include both English and Japanese when relevant
- Example: `tags: ["mcp", "server", "obsidian", "troubleshooting", "トラブルシューティング"]`

## 📝 Creating New Rules

### 1. **Planning Phase (PLAN Mode)**

Before creating a rule, consider:
- What problem does this rule solve?
- Which category does it belong to?
- Who is the target audience?
- Are there similar existing rules?

Open an issue to discuss if the rule:
- Introduces a new category
- Overlaps with existing rules
- Requires special considerations

### 2. **Create Your Feature Branch**

```bash
git checkout my-rules
git checkout -b feature/add-[rule-name]
```

### 3. **Rule File Structure**

All rule files MUST include YAML frontmatter:

```markdown
---
description: "Brief explanation of what this rule does"
author: "Your GitHub Username"
version: "1.0"
tags: ["relevant", "tags", "for", "categorization"]
globs: ["*.js", "*.ts"]  # File patterns where rule applies
---
# Rule Title

## Overview
Brief introduction to the rule's purpose.

## Guidelines

### MUST Requirements
- Use directive language: MUST, SHOULD, MAY, MUST NOT, NEVER
- Include practical examples
- Be specific and actionable

### Example
\```javascript
// Good example
const result = await processData(input);

// Bad example
const result = processData(input);  // Missing await
\```

## Additional Considerations
<thinking>
Complex logic explanations go here
</thinking>
```

### 4. **File Naming Conventions**

- Use kebab-case: `framework-name-guidelines.md`
- Be descriptive but concise
- Include version if applicable: `laravel11-coding-guidelines.md`

### 5. **Update rules-manifest.json**

After creating your rule, update the manifest:

```bash
./scripts/update-manifest.sh
```

This automatically extracts metadata and updates the manifest file.

## 🔄 Updating Existing Rules

### 1. **Version Increment**

When updating a rule:
- Patch version (1.0 → 1.1): Minor fixes, clarifications
- Minor version (1.1 → 2.0): Significant changes, new sections

### 2. **Document Changes**

In your commit message or PR, clearly describe:
- What changed
- Why it changed
- Any breaking changes

### 3. **Maintain Compatibility**

Consider existing users:
- Don't remove critical sections
- Add deprecation notices if needed
- Provide migration guidance

## 🧪 Testing Your Changes

### 1. **Run Validation Scripts**

Always validate before submitting:

```bash
# Validate all rules and manifest consistency
./scripts/validate-rules.sh

# Update manifest if you added/modified rules
./scripts/update-manifest.sh
```

### 2. **Test in Real Projects**

- Copy your rule to an actual project's `.clinerules` directory
- Test with Cline/Claude to ensure it works as expected
- Document any issues or edge cases

### 3. **Check for Conflicts**

Ensure your rule doesn't conflict with:
- Existing rules in the same category
- Core Cline behaviors
- Common development practices

## 📤 Submitting Changes

### 1. **Commit Message Format**

Follow conventional commits:

```
feat(rules): Add Python type hints guidelines
fix(coding): Update deprecated Laravel 11 methods
docs: Improve JavaScript examples
refactor(clinerules): Standardize metadata format
```

For Japanese documentation:
```
feat(rules): PythonタイプヒントガイドラインをAdd
docs: JavaScriptの例を改善
```

### 2. **Pull Request Process**

1. **Before submitting:**
   - [ ] All validation scripts pass
   - [ ] `rules-manifest.json` is updated
   - [ ] Version numbers are incremented
   - [ ] Changes are tested in real projects

2. **Create PR:**
   - Target: `my-rules` branch (NEVER `main`)
   - Title: Clear description of changes
   - Body: Include:
     - Motivation for changes
     - Testing performed
     - Any breaking changes
     - Related issues

3. **PR Template:**
   ```markdown
   ## Description
   Brief description of changes

   ## Type of Change
   - [ ] New rule
   - [ ] Rule update
   - [ ] Bug fix
   - [ ] Documentation
   - [ ] Translation

   ## Testing
   - [ ] Validated with `validate-rules.sh`
   - [ ] Tested in actual project
   - [ ] Manifest updated

   ## Related Issues
   Closes #XXX
   ```

### 3. **Review Process**

- Respond to feedback promptly
- Make requested changes
- Keep discussions professional
- Be open to suggestions

## 📚 Resources

### Internal Documentation
- [README.md](README.md) - Project overview and workflows
- [CLAUDE.md](CLAUDE.md) - AI-specific instructions
- [Writing Effective Clinerules](.clinerules/core-behavior/writing/writing-effective-clinerules.md)

### Example High-Quality Rules
- [JavaScript Coding Guidelines](.clinerules/coding/javascript-coding-guidelines.md)
- [Self-Improving Cline](.clinerules/core-behavior/self-improving-cline.md)
- [Sequential Thinking](.clinerules/core-behavior/MCP/sequential-thinking.md)

### External Resources
- [Cline Documentation](https://github.com/clinebot/cline)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Semantic Versioning](https://semver.org/)

## ❓ Frequently Asked Questions

### Why use `my-rules` branch instead of `main`?
The `main` branch is kept in sync with the upstream `cline/prompts` repository. All custom rules should be added to `my-rules` to maintain clear separation.

### How do I sync with upstream changes?
```bash
git checkout main
git fetch upstream
git merge upstream/main
```

### What's the difference between this fork and the original?
This fork maintains custom rules on the `my-rules` branch while keeping `main` synchronized with upstream for easy updates.

### How are rules prioritized when multiple apply?
Rules are applied based on:
1. Glob pattern matching
2. Specificity (more specific patterns take precedence)
3. Load order (later rules can override earlier ones)

### Can I contribute rules in Japanese only?
Yes, but please include at least a brief English description in the frontmatter. The main content can be in Japanese for workflow-related rules.

## 🤲 Code of Conduct

### Expected Behavior
- Be respectful and inclusive
- Provide constructive feedback
- Focus on improving AI assistant behaviors
- Help others learn and grow

### Unacceptable Behavior
- Harassment or discrimination
- Offensive comments
- Personal attacks
- Spam or off-topic content

## 📞 Getting Help

- **Issues**: Open an issue for bugs or feature requests
- **Discussions**: Use GitHub Discussions for questions
- **Direct Contact**: Mention @junichi-anada in issues for urgent matters

## 🙏 Acknowledgments

Thank you for contributing to make AI assistants more helpful and effective! Your contributions help the entire community work better with AI tools.

---

*This contributing guide is a living document. If you find areas that need clarification or improvement, please submit a PR!*