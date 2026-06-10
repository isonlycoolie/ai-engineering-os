<p align="center">
  <img src="docs/ai-engineering-os.png" alt="AI Engineering OS" width="480" />
</p>

<h1 align="center">AI Engineering OS</h1>

<p align="center">
  <strong>Portable engineering intelligence packages for AI-assisted software development.</strong>
</p>

<p align="center">
  <a href="#packages">Packages</a> ·
  <a href="#usage">Usage</a> ·
  <a href="CONTRIBUTING.md">Contributing</a> ·
  <a href="LICENSE">License</a>
</p>

---

## What this is

AI Engineering OS is a collection of **self-contained guidance packages** that improve how AI helps you build software. Each package is structured context for standards, workflows, prompts, and checklists.

Copy a package into your project. Reference it in Cursor, Claude, ChatGPT, Copilot, or any AI tool. **No install. No runtime. No enforced project structure.**

## What this is not

- Not a framework or codebase generator
- Not a project template or starter kit
- Not an MCP server or orchestration engine
- Not a mandate for how you organize folders or choose stacks

The product is **engineering intelligence**, not infrastructure.

Previous framework-style layout is preserved in git tag [`v1-legacy`](https://github.com/isonlycoolie/ai-engineering-os/tree/v1-legacy).

---

## Usage

### Step 1: Clone or download

```bash
git clone https://github.com/isonlycoolie/ai-engineering-os.git
```

### Step 2: Copy the package you need

Example: copy `frontend-ai-os/` into your project.

### Step 3: Place it anywhere

```
my-project/
├── src/
├── frontend-ai-os/     # your choice: root, docs/, tools/, etc.
└── package.json
```

### Step 4: Reference it in AI

```
Use ./frontend-ai-os while implementing the dashboard feature.
Follow standards.md and complete checklist.md before PR.
```

That is the entire workflow.

---

## Packages

| Package | Use when |
|---------|----------|
| [frontend-ai-os/](frontend-ai-os/) | UI, components, accessibility, client integration |
| [backend-ai-os/](backend-ai-os/) | APIs, services, persistence, server logic |
| [fullstack-ai-os/](fullstack-ai-os/) | Features spanning UI and API together |
| [devops-ai-os/](devops-ai-os/) | CI/CD, deploy gates, monitoring, incidents |
| [infrastructure-ai-os/](infrastructure-ai-os/) | IaC, cloud topology, environments |
| [cybersecurity-ai-os/](cybersecurity-ai-os/) | Threat modeling, auth review, hardening |
