#!/usr/bin/env bash

for domain in "$@"; do
	for protocol in http https; do
		for subdomain in "" www.; do
			url="$protocol://$subdomain$domain"
			echo -e "\033[0;34m--------------------------------------------------\033[0m"
			echo -e "\033[0;36m$url\033[0m"
			echo -e "\033[0;30m--------------------------------------------------\033[0m"
			if ! curl -I "$url"; then echo; fi
		done
	done
done
