#!/bin/bash

set_proxies() {
    http_proxy=$(jq -r '.PROXY_INFO[0].http_proxy' proxies.json)
    HTTP_PROXY=$(jq -r '.PROXY_INFO[0].HTTP_PROXY' proxies.json)
    https_proxy=$(jq -r '.PROXY_INFO[0].https_proxy' proxies.json)
    HTTPS_PROXY=$(jq -r '.PROXY_INFO[0].HTTPS_PROXY' proxies.json)
    ftp_proxy=$(jq -r '.PROXY_INFO[0].ftp_proxy' proxies.json)
    FTP_PROXY=$(jq -r '.PROXY_INFO[0].FTP_PROXY' proxies.json)
    socks_proxy=$(jq -r '.PROXY_INFO[0].socks_proxy' proxies.json)
    SOCKS_PROXY=$(jq -r '.PROXY_INFO[0].SOCKS_PROXY' proxies.json)
    no_proxy=$(jq -r '.PROXY_INFO[0].no_proxy' proxies.json)
    NO_PROXY=$(jq -r '.PROXY_INFO[0].NO_PROXY' proxies.json)

    if [[ -n "$http_proxy" ]]; then
        echo "export http_proxy=${http_proxy}" > proxy.sh
        echo "[Service]" > http-proxy.conf
        echo "Environment=\"http_proxy=$http_proxy\"" > http-proxy.conf
    fi
    if [[ -n "$HTTP_PROXY" ]]; then
        echo "export HTTP_PROXY=${HTTP_PROXY}" >> proxy.sh
        echo "Environment=\"HTTP_PROXY=$HTTP_PROXY\"" >> http-proxy.conf
    fi
    if [[ -n "$https_proxy" ]]; then
        echo "export https_proxy=${https_proxy}" >> proxy.sh
        echo "Environment=\"https_proxy=$https_proxy\"" >> http-proxy.conf
    fi
    if [[ -n "$HTTPS_PROXY" ]]; then
        echo "export HTTPS_PROXY=${HTTPS_PROXY}" >> proxy.sh
        echo "Environment=\"HTTPS_PROXY=$HTTPS_PROXY\"" >> http-proxy.conf
    fi
    if [[ -n "$ftp_proxy" ]]; then
        echo "export ftp_proxy=${ftp_proxy}" >> proxy.sh
        echo "Environment=\"ftp_proxy=$ftp_proxy\"" >> http-proxy.conf
    fi
    if [[ -n "$FTP_PROXY" ]]; then
        echo "export FTP_PROXY=${FTP_PROXY}" >> proxy.sh
        echo "Environment=\"FTP_PROXY=$FTP_PROXY\"" >> http-proxy.conf
    fi
    if [[ -n "$socks_proxy" ]]; then
        echo "export socks_proxy=${socks_proxy}" >> proxy.sh
        echo "Environment=\"socks_proxy=$socks_proxy\"" >> http-proxy.conf
    fi
    if [[ -n "$SOCKS_PROXY" ]]; then
        echo "export SOCKS_PROXY=${SOCKS_PROXY}" >> proxy.sh
        echo "Environment=\"SOCKS_PROXY=$SOCKS_PROXY\"" >> http-proxy.conf
    fi
    if [[ -n "$no_proxy" ]]; then
        echo "export no_proxy=${no_proxy}" >> proxy.sh
        echo "Environment=\"no_proxy=$no_proxy\"" >> http-proxy.conf
    fi
    if [[ -n "$NO_PROXY" ]]; then
        echo "export NO_PROXY=${NO_PROXY}" >> proxy.sh
        echo "Environment=\"NO_PROXY=$NO_PROXY\"" >> http-proxy.conf
    fi
}

    touch proxy.sh
    touch http-proxy.conf
    HOST_PROXY_FILE=`jq '.HOST_PROXY_FILE' proxies.json`
    DOCKER_PROXY_FILE=`jq '.DOCKER_PROXY_FILE' proxies.json`

    set_proxies
    echo "Please review generated 'proxy.sh' file and if it looks valid, copy " \
        "it over $HOST_PROXY_FILE accros all nodes within the cluster"

    echo "Please review generated 'http-proxy.conf' file and if it looks valid, " \
        "copy it over $DOCKER_PROXY_FILE accros all nodes within the cluster"

