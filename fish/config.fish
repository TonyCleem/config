# if test -e ~/.cache/wal/colors.fish
#     source ~/.cache/wal/colors.fish
# end
#
if status is-interactive
    starship init fish | source
end

export "MICRO_TRUECOLOR=1"
set -gx QT_QPA_PLATFORMTHEME qt6ct

alias cat="bat"
alias ls="eza -l --icons"
# alias py="python3"
alias matrix="unimatrix -s 93"
alias lock='~/.config/i3/scripts/lock'
alias v='vim'
alias nv='nvim'
alias py='python'
alias venv='source env/bin/activate.fish'
alias yz='yazi'
