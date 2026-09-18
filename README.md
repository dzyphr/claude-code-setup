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
{
  "amount": 3561,
  "currency": "USD",
  "balance": {
    "money": null,
    "credits": {
      "amount_minor": 3561,
      "exponent": 2
    }
  },
  "balance_credits": 35,
  "amount_without_scoped_credits": 3561,
  "auto_reload_settings": null,
  "pending_invoice_amount_cents": null,
  "last_paid_purchase_cents": null,
  "expiry_policy_months": null,
  "tranches": [],
  "promo_tranches": [
    {
      "remaining_amount_minor_units": 3560,
      "currency": "USD",
      "expires_at": "2026-09-19T00:00:00Z",
      "granted_amount_minor_units": 10000,
      "granted_at": "2026-07-21T04:17:45.649000Z",
      "remaining": {
        "money": null,
        "credits": {
          "amount_minor": 3560,
          "exponent": 2
        }
      },
      "granted": {
        "money": null,
        "credits": {
          "amount_minor": 10000,
          "exponent": 2
        }
      },
      "program_id": "credit_program_v2",
      "name": null,
      "id": "980e8b94-1814-4d94-b7a3-c427fb66f87d",
      "scope": {
        "kind": "unscoped",
        "applies_to": []
      }
    }
  ],
  "next_expires_at": "2026-09-19T00:00:00Z"
}

5-hour:  49.0%  (resets 22:00 UTC)
Weekly:  13.0%
Spent this month: $59.19


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
