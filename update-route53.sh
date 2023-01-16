IP=$(curl checkip.amazonaws.com)
jq '.Changes[].ResourceRecordSet.ResourceRecords[].Value="'$IP'"' r53record.json > updateroute53.json
aws route53 change-resource-record-sets --hosted-zone-id YOURZONEIDGOESHERE --change-batch file://updateroute53.json
