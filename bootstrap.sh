#!/usr/bin/env bash

check=$(bwrap --ro-bind / / true && echo OK)


if [[ "$check" != "OK" ]]; then
	printf "SANDBOX FAILURE EXITING"
	exit
fi

printf "SANDBOX SETUP: %s\n" "$check"

printf "\n\nINSTALLING CLAUDE CODE VIA \`https://claude.ai/install.sh\`...\n\n"

curl -fsSL https://claude.ai/install.sh | bash


printf "\n\nNOTE:\nIF THE INSTALLATION LOOKS SUCCESSFUL BUT YOU CANNOT FIND \`claude\` IN THE CURRENT TERMINAL YET SIMPLY RUN \`source ~/.bashrc\`\n\n"

./default-security-settings-heredoc.sh
