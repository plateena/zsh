#!/bin/bash
# don't sort git checkout output
zstyle ":completion:*:git-checkout:*" sort false

# when completing  environment variables, show their values (wrapped)
# in the preview window ("<unset>" if no value/empty string)
zstyle ":fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*" fzf-flags "--preview-window=wrap" "${FZF_TAB_DEFAULT_FZF_FLAGS[@]}"
zstyle ":fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*" fzf-preview "[[ -n \${(P)word} ]] && echo \${(P)word} || echo \<unset\>"

# use $ZLS_COLORS to color filenames by type
zstyle ":completion:*" list-colors "${(s.:.)ZLS_COLORS}"

# set descriptions format to enable options to be grouped into "completion groups"
zstyle ":completion:*:descriptions" format "[%d]"

 # switch between "completion groups" using ";" and "," keys
FZF_TAB_SWITCH_GROUP_FORWARD_CHAR=";"
FZF_TAB_SWITCH_GROUP_BACKWARD_CHAR=","
zstyle ":fzf-tab:*" switch-group "${FZF_TAB_SWITCH_GROUP_BACKWARD_CHAR}" "${FZF_TAB_SWITCH_GROUP_FORWARD_CHAR}"

# set prefix to prepend to each option (empty string/disabled in this case)
FZF_TAB_OPTIONS_PREFIX_STRING=
zstyle ":fzf-tab:*" prefix "${FZF_TAB_OPTIONS_PREFIX_CHAR}"

# default fzf settings to apply globally
FZF_TAB_DEFAULT_FZF_FLAGS=(
  "--height=~75%"
  "--multi" # TODO: still not working
  "--no-exact"
)
zstyle ":fzf-tab:*" fzf-flags "${FZF_TAB_DEFAULT_FZF_FLAGS[@]}"
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

# clean up namespace
unset FZF_TAB_SWITCH_GROUP_FORWARD_CHAR \
      FZF_TAB_SWITCH_GROUP_BACKWARD_CHAR \
      FZF_TAB_OPTIONS_PREFIX_STRING \
      FZF_TAB_DEFAULT_FZF_FLAGS
