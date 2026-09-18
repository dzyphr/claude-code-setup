if [ -e ~/.claude/settings.json ]; then
  echo "~/.claude/settings.json already exists, not overwriting."
else
  mkdir -p ~/.claude && cat > ~/.claude/settings.json << 'EOF'
{
  "permissions": {
    "defaultMode": "default",
    "disableBypassPermissionsMode": "disable",
    "deny": [
      "Bash(git commit:*)",
      "Bash(git push:*)",
      "Bash(git reset:*)",
      "Bash(git rebase:*)",
      "Bash(git remote:*)",
      "Bash(gh:*)",
      "Bash(sudo:*)",
      "Bash(rm -rf:*)",
      "Read(**/.env)",
      "Read(~/.ssh/**)"
    ]
  },
  "sandbox": {
    "enabled": true,
    "autoAllowBashIfSandboxed": false
  }
}
EOF
  echo "Created ~/.claude/settings.json"
fi
