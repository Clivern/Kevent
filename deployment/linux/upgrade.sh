#!/bin/bash

function kevent {
    echo "Upgrade kevent ..."

    cd /etc/kevent
    mv config.prod.yml config.back.yml

    LATEST_VERSION=$(curl --silent "https://api.github.com/repos/Clivern/kevent/releases/latest" | jq '.tag_name' | sed -E 's/.*"([^"]+)".*/\1/' | tr -d v)

    curl -sL https://github.com/Clivern/kevent/releases/download/v{$LATEST_VERSION}/kevent_{$LATEST_VERSION}_Linux_x86_64.tar.gz | tar xz

    rm config.prod.yml
    mv config.back.yml config.prod.yml

    systemctl restart kevent

    echo "kevent upgrade done!"
}

kevent
