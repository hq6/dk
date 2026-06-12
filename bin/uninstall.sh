#!/bin/bash


if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  >&2 echo "Detected OS Linux."
  bash_completion_dir=$HOME/.local/share/bash-completion/completions
elif [[  "$OSTYPE" == "darwin"*  ]]; then
  >&2 echo "Detected OS MacOS."
  bash_completion_dir="$(brew --prefix)/etc/bash_completion.d"
else
  >&2 echo "Unknown or supported OS '${OSTYPE}'. Exiting install script..."
  exit 1
fi

: ${INSTALL_TARGET_DIR:=$HOME/.local/bin}
: ${BASH_COMPLETION_DIR:=$bash_completion_dir}
: ${ZSH_COMPLETION_DIR:=$HOME/.local/share/zsh/site-functions}

>&2 cat <<EOF
Removing
  ${INSTALL_TARGET_DIR}/dk
  ${BASH_COMPLETION_DIR}/dk
  ${ZSH_COMPLETION_DIR}/_dk
EOF

rm -f \
  "${INSTALL_TARGET_DIR}/dk" \
  "${BASH_COMPLETION_DIR}/dk" \
  "${ZSH_COMPLETION_DIR}/_dk"
