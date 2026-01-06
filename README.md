# Claude Docusaurus Skills

A collection of Claude Code skills for working with Docusaurus projects and technical documentation.

## Available Skills

- **docusaurus-config** - Use when working with `docusaurus.config.js/ts` files to validate or modify Docusaurus configuration. Helps with required fields, URL formats, plugins, themes, and custom fields.

- **docusaurus-documentation** - Use when looking up information from the latest Docusaurus documentation at https://docusaurus.io/docs. Provides guidance on configuration, APIs, markdown features, and best practices.

- **docusaurus-migration** - Use when migrating Docusaurus projects from v2 to v3. Covers MDX v1 to v3 migration, dependency updates, React 18 compatibility, and breaking changes.

- **docusaurus-plugins** - Use when creating Docusaurus plugins (remark, rehype, theme, content, lifecycle) to extend markdown, modify HTML, or add custom functionality. Supports all five plugin types with detailed guides.

- **docusaurus-themes** - Use when swizzling Docusaurus theme components and editing theme elements. Provides guidance on safe wrapping vs. unsafe ejecting, component selection, and customization patterns.

- **google-style-guide** - Use when writing or reviewing technical documentation to follow Google's documentation style guide. Includes guidelines for voice, tense, formatting, inclusive language, and clarity principles.

## Installation

### Prerequisites

- **Node.js** 20.6 or higher
- **Git**
- **Claude Code** CLI

### Install as a Plugin

You can install all skills at once as a Claude Code plugin using the marketplace file:

```bash
claude mcp add-json docusaurus-skills '{"type":"stdio","command":"npx","args":["-y","claude-skills-cli","serve","https://raw.githubusercontent.com/mcclowes/claude-docusaurus-skills/main/.claude-plugin/marketplace.json"]}'
```

This registers all docusaurus skills as a single plugin that Claude Code can access.

### Install with OpenSkills

[OpenSkills](https://github.com/numman-ali/openskills) is a CLI tool that makes it easy to install and manage Claude Code skills.

#### Step 1: Install OpenSkills

```bash
npm i -g openskills
```

#### Step 2: Install Skills from this Repository

Install interactively (select which skills you want):

```bash
openskills install mcclowes/claude-docusaurus-skills
```

Or install all skills automatically:

```bash
openskills install mcclowes/claude-docusaurus-skills -y
```

#### Step 3: Sync Your Configuration (Optional)

If you have an `AGENTS.md` file, you can update it with:

```bash
openskills sync
```

### Installation Modes

**Project-level (default)**
Installs to `./.claude/skills/` in your current project:

```bash
openskills install mcclowes/claude-docusaurus-skills
```

**Global**
Installs to `~/.claude/skills/` for use across all projects:

```bash
openskills install mcclowes/claude-docusaurus-skills --global
```

**Universal mode**
Installs to `./.agent/skills/` for multi-agent setups:

```bash
openskills install mcclowes/claude-docusaurus-skills --universal
```

## Manual Installation

If you prefer to install manually without OpenSkills:

1. Clone this repository or download specific skill directories
2. Copy the skill directories to your `.claude/skills/` folder
3. Skills will be automatically available in Claude Code

## Ensuring Reliable Skill Activation

By default, Claude Code may not always activate skills when they're relevant. To ensure skills activate reliably (84% success rate vs ~20% without the hook), we recommend setting up the **forced eval hook** as described in [this blog post](https://scottspence.com/posts/how-to-make-claude-code-skills-activate-reliably#the-winner-sort-of-forced-eval-hook).

### Quick Setup (Recommended)

**Option 1: If you cloned this repository**

Run the automated setup script from your project root:

```bash
./setup-hook.sh
```

**Option 2: If you installed via OpenSkills**

Download the hook script directly:

```bash
# Create hooks directory
mkdir -p .claude/hooks

# Download the hook script
curl -o .claude/hooks/skill-activation-forced-eval.sh \
  https://raw.githubusercontent.com/mcclowes/claude-docusaurus-skills/main/hooks/skill-activation-forced-eval.sh

# Make it executable
chmod +x .claude/hooks/skill-activation-forced-eval.sh

# Then manually configure settings.json (see Manual Setup below)
```

The setup script will:
- Copy the forced eval hook to `.claude/hooks/skill-activation-forced-eval.sh`
- Configure `.claude/settings.json` with the hook
- Make the hook executable

### Manual Setup

If you prefer to set it up manually:

1. **Create the hooks directory** (if it doesn't exist):
   ```bash
   mkdir -p .claude/hooks
   ```

2. **Copy the hook script**:
   ```bash
   cp hooks/skill-activation-forced-eval.sh .claude/hooks/skill-activation-forced-eval.sh
   chmod +x .claude/hooks/skill-activation-forced-eval.sh
   ```

3. **Configure settings.json**:
   
   Create or update `.claude/settings.json` with:
   ```json
   {
     "hooks": {
       "UserPromptSubmit": [
         {
           "hooks": [
             {
               "type": "command",
               "command": ".claude/hooks/skill-activation-forced-eval.sh"
             }
           ]
         }
       ]
     }
   }
   ```

4. **Restart Claude Code** for changes to take effect.

### How It Works

The forced eval hook requires Claude to:
1. **Evaluate** each available skill and explicitly state YES/NO with reasoning
2. **Activate** relevant skills immediately using the `Skill()` tool
3. **Implement** the task only after skills are activated

This ensures skills are explicitly considered and activated when relevant, rather than being skipped during Claude's normal workflow.

## Usage

Once installed, skills will be automatically available in Claude Code. Simply reference them in your prompts, and Claude will utilize the appropriate skill based on your task.

### Example Usage

**For documentation writing:**
```
Help me write API documentation following the Google style guide
```

**For Docusaurus theme customization:**
```
I want to customize my Docusaurus footer to add social media links
```

```
Help me swizzle the Navbar component safely
```

## License

See [LICENCE](LICENCE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests to improve these skills.
