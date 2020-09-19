#!/bin/bash

source /etc/profile

export PS1_GREEN="\[$(tput bold)$(tput setaf 2)\]"
export PS1_RESET="\[$(tput sgr0)\]"
export PROMPT_COMMAND='PS1="${PS1_GREEN}[FRONTEND-DEV] ${PS1_RESET}\W${PS1_GREEN} > ${PS1_RESET}"'

bash
