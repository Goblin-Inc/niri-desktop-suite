#!/bin/bash

# Получаем календарь с подсвеченной сегодняшней датой
TODAY=$(date +%e | tr -d ' ')
MONTH_YEAR=$(date +"%B %Y")
CAL_BODY=$(cal | tail -n +2 | sed "s/\b$TODAY\b/<b><u>$TODAY<\/u><\/b>/")

# Вывод через системное уведомление
notify-send -a "System Calendar" "$MONTH_YEAR - $TODAY" "<tt>$CALL_BODY</tt>" -t 5000
