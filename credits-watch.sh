#!/usr/bin/env bash
sudo apt install jq curl sqlite3 python3-venv
python3 -m venv ~/.venvs/cookies
~/.venvs/cookies/bin/pip install browser-cookie3

~/.venvs/cookies/bin/pip install curl_cffi

set -u

VENV_PY="$HOME/.venvs/cookies/bin/python"
REFRESH=60

ORG=$(jq -r '.oauthAccount.organizationUuid // empty' "$HOME/.claude.json" 2>/dev/null)
if [ -z "$ORG" ]; then
  echo "No organization ID in ~/.claude.json. Log into Claude Code first."
  exit 1
fi

while true; do
  clear
  echo "Updated $(date +%T)"
  echo

  "$VENV_PY" - "$ORG" << 'PY'
import sys
from datetime import datetime, timezone
import browser_cookie3
from curl_cffi import requests

org = sys.argv[1]
cookies = None
for loader in (browser_cookie3.brave, browser_cookie3.firefox):
    try:
        found = {c.name: c.value for c in loader(domain_name="claude.ai")}
        if "sessionKey" in found:
            cookies = found
            break
    except Exception:
        pass

if cookies is None:
    print("Credits:  no claude.ai login found")
    sys.exit()

try:
    r = requests.get(
        f"https://claude.ai/api/organizations/{org}/prepaid/credits",
        cookies=cookies, impersonate="chrome", timeout=20,
    )
    data = r.json()
except Exception:
    print("Credits:  unavailable (blocked or logged out)")
    sys.exit()

promos = data.get("promo_tranches") or []
if not promos:
    print(f"Credits:  ${data.get('amount', 0) / 100:.2f}")

for t in promos:
    left = t.get("remaining_amount_minor_units", 0) / 100
    granted = t.get("granted_amount_minor_units", 0) / 100
    line = f"Promo:    ${left:.2f} of ${granted:.2f} left (assuming 100$ Claude promo)"
    exp = t.get("expires_at")
    if exp:
        secs = int((datetime.fromisoformat(exp.replace("Z", "+00:00"))
                    - datetime.now(timezone.utc)).total_seconds())
        if secs > 0:
            h, m = divmod(secs // 60, 60)
            line += f"  (expires in {h}h {m:02d}m)"
        else:
            line += "  (expired)"
    print(line)
PY

  TOKEN=$(jq -r '.claudeAiOauth.accessToken // empty' "$HOME/.claude/.credentials.json" 2>/dev/null)
  if [ -n "$TOKEN" ]; then
    curl -s https://api.anthropic.com/api/oauth/usage \
      -H "anthropic-beta: oauth-2025-04-20" \
      -H @- <<< "Authorization: Bearer $TOKEN" | jq -r '
        "5-hour:   \(.five_hour.utilization)%  (resets \(.five_hour.resets_at[11:16]) UTC)",
        "Weekly:   \(.seven_day.utilization)%"' 2>/dev/null \
      || echo "Usage:    unavailable"
  else
    echo "Usage:    no Claude Code login found"
  fi
  unset TOKEN

  sleep "$REFRESH"
done
