#Get the public IP and resolve the DNS name - replace the "replace.withyour.fqdn" address with the hostname you are updating
IP=$(curl checkip.amazonaws.com)
DNS=$(dig +short replace.withyour.fqdn)
#compare the results - if they do not match update the DNS.
if [[ "$IP" != "$DNS" ]];
then
jq '.Changes[].ResourceRecordSet.ResourceRecords[].Value="'$IP'"' r53record.json > updateroute53.json
aws route53 change-resource-record-sets --hosted-zone-id YOURZONEIDGOESHERE --change-batch file://updateroute53.json
fi
