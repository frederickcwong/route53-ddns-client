#!/bin/bash

# exit when receiving SIGTERM
trap exit TERM

DIR="$( cd "$( dirname "$0" )" && pwd )"

# make sure all required values are present
[[ -z "$ROUTE53_HOSTNAME" ]] ||
  [[ -z "$ROUTE53_SECRET" ]] ||
  [[ -z "$ROUTE53_API_KEY" ]] ||
  [[ -z "$ROUTE53_API_URL" ]] && 
  
  echo "Error: one or more route53 env variables are not set. Exiting..." && exit 1

# if schedule is not set, default to running the script every hour
if [ -z "$ROUTE53_SCHEDULE" ]
then
    echo "ROUTE53_SCHEDULE not set, default to 15m"
    ROUTE53_SCHEDULE=15m
fi

while :
do
    $DIR/route53-ddns.sh
    sleep ${ROUTE53_SCHEDULE} & 
    wait ${!}
done
