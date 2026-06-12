#!/bin/bash

# Install the dk binary and the completion scripts for bash and zsh.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR/.."

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


# Install the local build of dk and the completion scripts.
if [[ -z "$FROM_RELEASE" ]]; then
  # If installing from release, do not attempt to build.
  make
fi
>&2 echo

: ${INSTALL_TARGET_DIR:=$HOME/.local/bin}
>&2 echo "Installing 'dk' into '$INSTALL_TARGET_DIR'. Please ensure that this directory is in your PATH."$'\n'
mkdir -p ~/.local/bin
cp dk "$INSTALL_TARGET_DIR"

# Install completions
: ${BASH_COMPLETION_DIR:=$bash_completion_dir}
: ${ZSH_COMPLETION_DIR:=$HOME/.local/share/zsh/site-functions}
mkdir -p "$BASH_COMPLETION_DIR" "$ZSH_COMPLETION_DIR"

>&2 cat <<EOF
Installing bash completions into '$BASH_COMPLETION_DIR'.
If you are running an older Intel mac and completions are not working you may
need to ensure '$HOME/.bash_profile' has the following line:

  source /usr/local/etc/profile.d/bash_completion.sh

EOF
cp completions/bash-completion.sh "$BASH_COMPLETION_DIR/dk"

>&2 cat <<EOF
Installing zsh completions into '$ZSH_COMPLETION_DIR'.
Please ensure that this directory is set in your \$fpath
before the following lines in your $HOME/.zshrc:
  autoload -Uz compinit
  compinit
EOF
cp completions/zsh-completion.sh "${ZSH_COMPLETION_DIR}/_dk"
