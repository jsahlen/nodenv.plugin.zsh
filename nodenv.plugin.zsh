found_nodenv=''
nodenvdirs=("$HOME/.nodenv" "$HOME/.local/nodenv" "/usr/local/opt/nodenv" "/usr/local/nodenv" "/opt/nodenv")

for nodenvdir in "${nodenvdirs[@]}" ; do
  if [ -z "$found_nodenv" ] && [ -d "$nodenvdir/versions" ]; then
    found_nodenv=true
    if [ -z "$NODENV_ROOT" ]; then
      NODENV_ROOT="$nodenvdir"
      export NODENV_ROOT
    fi
    export PATH="${nodenvdir}/bin:$PATH"
    eval "$(nodenv init --no-rehash -)"

    function current_node() {
      echo "$(nodenv version-name)"
    }

    function nodenv_prompt_info() {
      echo "$(current_node)"
    }
  fi
done
unset nodenvdir

if [ -z "$found_nodenv" ]; then
  function nodenv_prompt_info() {
     echo "system: $(node --version)"
  }
fi
