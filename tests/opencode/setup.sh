#!/usr/bin/env bash
# Setup script for OpenCode plugin tests
# Creates an isolated test environment with proper plugin installation
set -euo pipefail

# Get the repository root (two levels up from tests/opencode/)
REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

# Create temp home directory for isolation
export TEST_HOME=$(mktemp -d)
export HOME="$TEST_HOME"
export XDG_CONFIG_HOME="$TEST_HOME/.config"
export OPENCODE_CONFIG_DIR="$TEST_HOME/.config/opencode"

# Install plugin to test location
mkdir -p "$HOME/.config/opencode/superpowers/plugins"
cp -r "$REPO_ROOT/plugins/superpowers-zh" "$HOME/.config/opencode/superpowers/plugins/"

PLUGIN_FILE="$HOME/.config/opencode/superpowers/plugins/superpowers-zh/.opencode/plugins/superpowers.js"

# Register plugin through opencode.json, matching OpenCode's plugin mechanism.
cat > "$HOME/opencode.json" <<EOF
{
  "plugin": ["file://$PLUGIN_FILE"]
}
EOF

# Create test skills in different locations for testing

# Personal test skill
mkdir -p "$HOME/.config/opencode/skills/personal-test"
cat > "$HOME/.config/opencode/skills/personal-test/SKILL.md" <<'EOF'
---
name: personal-test
description: Test personal skill for verification
---
# Personal Test Skill

This is a personal skill used for testing.

PERSONAL_SKILL_MARKER_12345
EOF

# Create a project directory for project-level skill tests
mkdir -p "$TEST_HOME/test-project/.opencode/skills/project-test"
cat > "$TEST_HOME/test-project/.opencode/skills/project-test/SKILL.md" <<'EOF'
---
name: project-test
description: Test project skill for verification
---
# Project Test Skill

This is a project skill used for testing.

PROJECT_SKILL_MARKER_67890
EOF

cat > "$TEST_HOME/test-project/opencode.json" <<EOF
{
  "plugin": ["file://$PLUGIN_FILE"]
}
EOF

echo "Setup complete: $TEST_HOME"
echo "Plugin installed to: $PLUGIN_FILE"
echo "Plugin registered in: $HOME/opencode.json"
echo "Test project at: $TEST_HOME/test-project"

# Helper function for cleanup (call from tests or trap)
cleanup_test_env() {
    if [ -n "${TEST_HOME:-}" ] && [ -d "$TEST_HOME" ]; then
        rm -rf "$TEST_HOME"
    fi
}

# Export for use in tests
export -f cleanup_test_env
export REPO_ROOT
export PLUGIN_FILE
