FZF_LS_TOOL_DIR=${FZF_LS_TOOL_DIR-${0:A:h}}

function fzf_ls() {
  strings=$(python ${FZF_LS_TOOL_DIR}/main/range.py "$BUFFER" $CURSOR)
  left=$(sed -n '1p' <<< "${strings}")
  center=$(sed -n '2p' <<< "${strings}")
  right=$(sed -n '3p' <<< "${strings}")
  if [[ "$center" = "/" ]]; then
    out=$(fzfyml3 run ${FZF_LS_TOOL_DIR}/main/fzf_ls.yml "/" "")
  elif echo "$center" | grep -q '/$'; then
    out=$(fzfyml3 run ${FZF_LS_TOOL_DIR}/main/fzf_ls.yml "${center%%/}" "")
  else
    out=$(fzfyml3 run ${FZF_LS_TOOL_DIR}/main/fzf_ls.yml . "$center")
  fi
  if [[ -n "$out" ]]; then
    BUFFER="${left}${out}${right}"
    CURSOR=$((${#BUFFER} - ${#right} + 1))
    zle redisplay
  fi
}
zle -N fzf_ls
bindkey '^s' fzf_ls

