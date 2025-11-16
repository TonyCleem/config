# if test -e ~/.cache/wal/colors.fish
#     source ~/.cache/wal/colors.fish
# end
#
if status is-interactive
    starship init fish | source
end

if set -q TMUX
    set -gx TERM tmux-256color
end

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
alias ff='fastfetch'
