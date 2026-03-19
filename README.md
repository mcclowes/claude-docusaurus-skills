# Claude Docusaurus Skills

A collection of agent skills for working with Docusaurus projects and technical documentation.

## Installation

```bash
npx skills add mcclowes/claude-docusaurus-skills
```

Install specific skills only:

```bash
npx skills add mcclowes/claude-docusaurus-skills --skill docusaurus-config
```

Install globally (available across all projects):

```bash
npx skills add mcclowes/claude-docusaurus-skills -g
```

Preview available skills before installing:

```bash
npx skills add mcclowes/claude-docusaurus-skills --list
```

## Available skills

| Skill | Description |
|-------|-------------|
| **docusaurus-config** | Validate and modify `docusaurus.config.js/ts` — required fields, URL formats, plugins, themes, custom fields |
| **docusaurus-documentation** | Look up the latest Docusaurus documentation — configuration, APIs, markdown features, best practices |
| **docusaurus-v2-to-v3-migration** | Migrate from Docusaurus v2 to v3 — MDX v1→v3, dependency updates, React 18 compatibility, breaking changes |
| **docusaurus-plugins** | Create Docusaurus plugins (remark, rehype, theme, content, lifecycle) to extend functionality |
| **docusaurus-themes** | Swizzle and customize Docusaurus theme components — navbar, footer, sidebar, layouts |
| **google-style-guide** | Write and review technical documentation following Google's documentation style guide |

## Alternative installation methods

### As a Claude Code plugin

```bash
claude mcp add-json docusaurus-skills '{"type":"stdio","command":"npx","args":["-y","claude-skills-cli","serve","https://raw.githubusercontent.com/mcclowes/claude-docusaurus-skills/main/.claude-plugin/marketplace.json"]}'
```

### With OpenSkills

```bash
npm i -g openskills
openskills install mcclowes/claude-docusaurus-skills
```

### Manual

Copy skill directories from `skills/` to your `.claude/skills/` folder.

## Ensuring reliable skill activation

By default, Claude Code may not always activate skills when relevant. For more reliable activation, set up the **forced eval hook**:

```bash
./setup-hook.sh
```

Or manually:

1. Copy the hook: `cp hooks/skill-activation-forced-eval.sh .claude/hooks/`
2. Make executable: `chmod +x .claude/hooks/skill-activation-forced-eval.sh`
3. Add to `.claude/settings.json`:

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

4. Restart Claude Code.

See [this blog post](https://scottspence.com/posts/how-to-make-claude-code-skills-activate-reliably#the-winner-sort-of-forced-eval-hook) for details.

## License

See [LICENCE](LICENCE) file for details.

## Contributing

Contributions welcome — please feel free to submit issues or pull requests.
