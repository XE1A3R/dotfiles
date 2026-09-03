#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/wallpapers/"
INTERVAL=600  # если нужна периодичность, можно оставить цикл; пока просто однократно

# Ждём, пока hyprpaper запустится (максимум 5 секунд)
TIMEOUT=5
while ! pgrep -x "hyprpaper" > /dev/null && [ $TIMEOUT -gt 0 ]; do
    sleep 0.5
    ((TIMEOUT--))
done

if ! pgrep -x "hyprpaper" > /dev/null; then
    echo "hyprpaper не запущен, выходим" >> /tmp/hyprpaper.log
    exit 1
fi

# Выбираем случайное изображение
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
if [ -z "$WALLPAPER" ]; then
    echo "Не найдено ни одного изображения в $WALLPAPER_DIR" >> /tmp/hyprpaper.log
    exit 1
fi

# Применяем обои
hyprctl hyprpaper preload "$WALLPAPER"
hyprctl hyprpaper wallpaper ,"$WALLPAPER"

# Если хотите периодически менять, раскомментируйте цикл:
 while true; do
     WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
     hyprctl hyprpaper preload "$WALLPAPER"
     hyprctl hyprpaper wallpaper ,"$WALLPAPER"
     sleep $INTERVAL
 done
