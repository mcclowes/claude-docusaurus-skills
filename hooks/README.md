# Hook Scripts

This directory contains hook scripts that can be used to ensure reliable skill activation in Claude Code.

## skill-activation-forced-eval.sh

This hook forces Claude to explicitly evaluate and activate relevant skills before proceeding with implementation. This approach achieves an 84% skill activation success rate compared to ~20% without the hook.

### Installation

See the main [README.md](../README.md) for installation instructions.

### How It Works

The forced eval hook uses Claude Code's `UserPromptSubmit` hook to inject instructions that require Claude to:

1. **Evaluate**: Explicitly review each available skill and state YES/NO with reasoning
2. **Activate**: Immediately use the `Skill()` tool for any relevant skills
3. **Implement**: Only proceed with the task after skills are activated

This ensures skills are not skipped during Claude's normal workflow.

### References

- [Blog Post: How to Make Claude Code Skills Activate Reliably](https://scottspence.com/posts/how-to-make-claude-code-skills-activate-reliably#the-winner-sort-of-forced-eval-hook)
- [Claude Code Hooks Documentation](https://docs.claude.com/en/docs/claude-code/hooks)

