#!/usr/bin/env bash
theme="$HOME/.config/rofi/search_projects.rasi"
DIR="$HOME/Обучение/Devman/"
PROJECT=$(ls "$DIR" | rofi -dmenu -p "Projects:" -theme "$theme")

[ -z "$PROJECT" ] && exit
cd "$DIR/$PROJECT" || exit
alacritty -e tmux new-session -As "$PROJECT"
