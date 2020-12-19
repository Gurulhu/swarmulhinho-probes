#!/usr/bin/env sh

sed -i "s/QUERY/${QUERY}/g" ./config/config.exs
sed -i "s/JIRA_BASE_URL/${JIRA_BASE_URL}/g" ./config/config.exs
sed -i "s/JIRA_USER/${JIRA_USER}/g" ./config/config.exs
sed -i "s/JIRA_PASSWORD/${JIRA_PASSWORD}/g" ./config/config.exs
sed -i "s/AMQP_SERVER_STRING/${AMQP_SERVER_STRING}/g" ./config/config.exs
sed -i "s/TELEGRAM_CHAT/${TELEGRAM_CHAT}/g" ./config/config.exs

mix run --no-halt
