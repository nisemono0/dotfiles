#%{$fg_bold[green]%}%n@%m %{$reset_color%}

# Show date
# PROMPT=$'%{$fg[green]%}%D{{%X}} %{$fg[blue]%}[%~]%{$reset_color%} $(git_prompt_info) %{$fg_bold[red]%}→%{$reset_color%} '

# Show user

PROMPT=$'%{$fg[green]%}%n@%m %{$reset_color%}%{$fg[blue]%}[%~]%{$reset_color%} $(git_prompt_info)%{$fg_bold[red]%}→%{$reset_color%} '


ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[green]%} "
ZSH_THEME_GIT_PROMPT_CLEAN=""

