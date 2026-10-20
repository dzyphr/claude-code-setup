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


cp ~/.claude/settings.json ~/.claude/settings.json.bak && jq '(.permissions.deny // []) as $e
| . * {permissions:{defaultMode:"default",disableBypassPermissionsMode:"disable"},
 sandbox:{enabled:true,autoAllowBashIfSandboxed:false}}
| .permissions.deny = ($e + (["Bash(git commit:*)","Bash(git push:*)","Bash(git reset:*)","Bash(git rebase:*)","Bash(git remote:*)","Bash(gh:*)","Bash(sudo:*)","Bash(rm
-rf:*)","Read(**/.env)","Read(~/.ssh/**)"] - $e))'   ~/.claude/settings.json.bak > ~/.claude/settings.json && cat ~/.claude/settings.json
