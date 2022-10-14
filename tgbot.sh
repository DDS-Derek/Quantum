#!/bin/bash

. /app/config.sh
. /app/docker_status.sh

Text_Send=$(echo -e "$(date) \nDocker Running Container \
            \n \
            $(expr $(docker ps --all --format "table {{.Names}} {{.Status}} " -f status=running | wc -l) - 1) \
            \n \
            \n${Docker_Running_Container}")

curl -s -k "https://api.telegram.org/bot${TGBOT_SEND_TOKEN}/sendMessage" \
    --data-urlencode "chat_id=${TGBOT_SEND_CHATID}" \
    --data-urlencode "text=${Text_Send}"