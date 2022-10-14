#!/bin/bash

. ${Quantum_Config_DIR}/config.sh
. /quantum/app/quantum/docker_status.sh

curl -s -k "https://api.telegram.org/bot${TGBOT_SEND_TOKEN}/sendMessage" \
    --data-urlencode "chat_id=${TGBOT_SEND_CHATID}" \
    --data-urlencode "text=${Text_Send}"