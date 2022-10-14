#!/bin/bash

. ${Quantum_Config_DIR}/config.sh
. /quantum/app/quantum/docker_status.sh

sendEmail \
	-f ${FROM_EMAIL} \
	-s ${MAILER_HOST} \
	-t ${TO_EMAIL} \
	-xu ${MAILER_USER} \
	-xp ${MAILER_PASSWORD} \
	-o tls=${TLS} \
	-u Quantum 通知 \
	-m ${Text_Send} \
	-o message-content-type=html \
	-o message-charset=utf-8