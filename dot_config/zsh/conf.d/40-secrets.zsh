# Secrets live in the macOS Keychain, never in files.
#   Add or update:  security add-generic-password -U -a "$USER" -s OPENAI_API_KEY -w
#                   (-w last = it asks for the value, so nothing is saved in history)
#   Remove:         security delete-generic-password -a "$USER" -s OPENAI_API_KEY

secret() {
  security find-generic-password -a "$USER" -s "$1" -w 2>/dev/null
}

# Pass secrets to ONE command only (nothing stays in your shell):
#   with-secrets OPENAI_API_KEY ANTHROPIC_API_KEY -- python app.py
with-secrets() {
  local -a envs
  local name val
  while (( $# )) && [[ $1 != -- ]]; do
    name=$1; shift
    val=$(secret "$name") || { print -u2 "secret not found: $name"; return 1 }
    envs+=("$name=$val")
  done
  [[ $1 == -- ]] && shift
  env "${envs[@]}" "$@"
}

# Export into the current shell when you really need to:  load-secret OPENAI_API_KEY
load-secret() {
  local val
  val=$(secret "$1") || { print -u2 "secret not found: $1"; return 1 }
  export "$1=$val"
}
