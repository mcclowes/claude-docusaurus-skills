#!/bin/bash
# Setup script for the forced eval hook
# This script automatically configures the hook to ensure skills activate reliably

set -e

HOOKS_DIR=".claude/hooks"
SETTINGS_FILE=".claude/settings.json"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOOK_SOURCE="$SCRIPT_DIR/hooks/skill-activation-forced-eval.sh"
HOOK_DEST="$HOOKS_DIR/skill-activation-forced-eval.sh"

# Create .claude/hooks directory if it doesn't exist
mkdir -p "$HOOKS_DIR"

# Copy the hook script
echo "📋 Copying forced eval hook to $HOOK_DEST..."
cp "$HOOK_SOURCE" "$HOOK_DEST"
chmod +x "$HOOK_DEST"

# Create or update settings.json
if [ ! -f "$SETTINGS_FILE" ]; then
  echo "📝 Creating $SETTINGS_FILE..."
  cat > "$SETTINGS_FILE" <<'EOF'
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
EOF
else
  echo "⚠️  $SETTINGS_FILE already exists. Checking if hook is configured..."
  
  # Check if the hook is already configured
  if grep -q "skill-activation-forced-eval.sh" "$SETTINGS_FILE"; then
    echo "✅ Hook is already configured in $SETTINGS_FILE"
  else
    echo "⚠️  Hook not found in $SETTINGS_FILE"
    echo "   Please add the following to the \"hooks\" section:"
    echo ""
    echo "   {"
    echo "     \"hooks\": {"
    echo "       \"UserPromptSubmit\": ["
    echo "         {"
    echo "           \"hooks\": ["
    echo "             {"
    echo "               \"type\": \"command\","
    echo "               \"command\": \".claude/hooks/skill-activation-forced-eval.sh\""
    echo "             }"
    echo "           ]"
    echo "         }"
    echo "       ]"
    echo "     }"
    echo "   }"
  fi
fi

echo ""
echo "✅ Setup complete! The forced eval hook is now configured."
echo "   This will ensure skills activate reliably (84% success rate)."
echo ""
echo "💡 Note: You may need to restart Claude Code for changes to take effect."

