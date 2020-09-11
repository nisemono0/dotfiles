USER_NAME="%{$fg[blue]%}%n"
AT_SYMB="%{$fg[blue]%}@"
MACHINE_NAME="%{$fg[blue]%}%m"
CURR_DIR=" %{$reset_color%}%{$fg[green]%}[%~]"
GIT_ST="%{$reset_color%} \$(git_prompt_info)"
ARROW="%{$fg_bold[red]%}»%{$reset_color%} "

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[cyan]%}*%{$fg[yellow]%} "
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT="$USER_NAME$AT_SYMB$MACHINE_NAME$CURR_DIR$GIT_ST$ARROW"