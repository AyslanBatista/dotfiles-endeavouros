# fino.zsh-theme

# Use with a dark background and 256-color terminal!
# Meant for people with rbenv and git. Tested only on OS X 10.7.

# You can set your computer name in the ~/.box-name file if you want.

# Borrowing shamelessly from these oh-my-zsh themes:
#   bira
#   robbyrussell
#
# Also borrowing from http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/

function virtualenv_prompt_info {
  [[ -n ${VIRTUAL_ENV} ]] || return
  echo "${ZSH_THEME_VIRTUALENV_PREFIX:=[}${VIRTUAL_ENV:t}${ZSH_THEME_VIRTUALENV_SUFFIX:=]}"
}

function prompt_char {
  command git branch &>/dev/null && echo "±" || echo '○'
}

function box_name {
  local box="${SHORT_HOST:-$HOST}"
  [[ -f ~/.box-name ]] && box="$(< ~/.box-name)"
  echo "${box:gs/%/%%}"
}
#029 #019 #039 #049 #059 #069 #079 #089 #099 #109 #119 #129 #139 #149 #306 #011 #012
#021 blue escuro
local ruby_env='$(ruby_prompt_info)'
local git_info='$(git_prompt_info)'
local virtualenv_info='$(virtualenv_prompt_info)'
local prompt_char='$(prompt_char)'
#040 
PROMPT="${FG[039]}╭─${virtualenv_info}${ruby_env}${FG[012]}[${FG[040]}%n${FG[012]}]${FG[012]}[${FG[033]}$(box_name)${FG[012]}]${FG[239]}${FG[012]}[%B${FG[202]}%~%b${git_info}${FG[012]}]
${FG[039]}╰─${prompt_char}%{$reset_color%} "

ZSH_THEME_GIT_PROMPT_PREFIX=" ${FG[239]}on%{$reset_color%} ${FG[255]}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="${FG[045]}✘✘✘"
ZSH_THEME_GIT_PROMPT_CLEAN="${FG[040]}✔"

ZSH_THEME_RUBY_PROMPT_PREFIX=" ${FG[239]}using${FG[243]} ‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="›%{$reset_color%}"

export VIRTUAL_ENV_DISABLE_PROMPT=1
ZSH_THEME_VIRTUALENV_PREFIX="${FG[012]}(${FG[093]}«"
ZSH_THEME_VIRTUALENV_SUFFIX="»${FG[012]})%{$reset_color%}"
