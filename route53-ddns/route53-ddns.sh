#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

echo "--------------------------------------------------"
echo "DDNS script runs on: `date`"

MY_IP=$(dig +short myip.opendns.com @resolver4.opendns.com)
DNS_IP=$(dig +short $ROUTE53_HOSTNAME @resolver4.opendns.com)

if [ -z "$MY_IP" ] || [ -z "$DNS_IP" ]; then
	echo "Internet disconnected"
else 
	echo "Current IP: "$MY_IP
	echo "DNS IP: "$DNS_IP
	if [[ $DNS_IP != $MY_IP ]]; then
		# they are different. updating route53
		$DIR/route53-ddns-client.sh --hostname $ROUTE53_HOSTNAME --secret $ROUTE53_SECRET --api-key $ROUTE53_API_KEY --url $ROUTE53_API_URL
		echo "WanIP update completed."
	else
		echo "WanIP no change. Nothing to update."
	fi
fi

echo "--------------------------------------------------"
