# Claude Code Setup

Reproducible setup intended to exhaust promotional credits and convert them into vibe coded masterpieces

## `bubblewrap` + `socat` sandboxed for security

Uses `bubblewrap` and `socat` tools to isolate Claude's commands at the OS level and handle a network proxy securely

enable with `/sandbox` once inside, set to manual permissions recommended

## No GitHub side-effects 

use `./git-lockdown.sh` to make it so Claude never pushes or commits to GitHub

## Customizable 

find security settings config at `~/.claude/settings.json`

default security settings:

```
{
  "permissions": {
    "defaultMode": "default",
    "disableBypassPermissionsMode":Credits:
  "disable",
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
```

## Watch your credits

`./credit-watch.sh`
