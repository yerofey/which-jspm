WHICH_JPSM_PROMPT=''
NPM_PROMPT="%K{#cd3534}%F{#ffffff} npm %F{reset}%K{reset} "
YARN_PROMPT="%K{#2d8ebb}%F{#ffffff} yarn %F{reset}%K{reset} "
PNPM_PROMPT="%K{#f9ad01}%F{#ffffff} pnpm %F{reset}%K{reset} "

function found_package() {
  if test -f "package-lock.json" && [[ "$WHICH_JPSM_PROMPT" != *"$NPM_PROMPT"* ]]; then
    WHICH_JPSM_PROMPT+=$NPM_PROMPT
  fi

  if test -f "yarn.lock" && [[ "$WHICH_JPSM_PROMPT" != *"$YARN_PROMPT"* ]]; then
    WHICH_JPSM_PROMPT+=$YARN_PROMPT
  fi

  if test -f "pnpm-lock.yaml" && [[ "$WHICH_JPSM_PROMPT" != *"$PNPM_PROMPT"* ]]; then
    WHICH_JPSM_PROMPT+=$PNPM_PROMPT
  fi
}

add-zsh-hook chpwd chpwd_which_jspm
chpwd_which_jspm() {
  if test -f "package.json";
  then
    PROMPT_ORIG=${PROMPT%$WHICH_JPSM_PROMPT}
    JPSM_PROMPT_BEFORE=${PROMPT//$PROMPT_ORIG/}

    found_package
    
    if [[ "$JPSM_PROMPT_BEFORE" != "$WHICH_JPSM_PROMPT" ]]; then
      PROMPT+=$WHICH_JPSM_PROMPT
    fi
  elif [ "$WHICH_JPSM_PROMPT" != '' ]
  then
    PROMPT=${PROMPT%$WHICH_JPSM_PROMPT}
    WHICH_JPSM_PROMPT=''
  fi
}
