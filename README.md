## Dyn-route53 

This script changes an IP from your localhost dynamically.

### Please change the following values to make it work:

* The zone ID **YOURZONEIDGOESHERE** in [update-route53.sh](https://github.com/markosluga/change-route53/blob/main/update-route53.sh). Your zone id can be found in the AWS Route53 managemnt console and consists of upercase characters and numbers.
* The **replace.withyour.fqdn** record with the record you are trying to modify both in [update-route53.sh](https://github.com/markosluga/change-route53/blob/main/update-route53.sh) line 3 (the dig command) and in [route53-stub.json](https://github.com/markosluga/change-route53/blob/main/route53-stub.json) at line 6 as the value for the "Name" key. This is the record you are trying to change. 
* If you are looking to change another record type you are welocme to change the "Type" value in in [route53-stub.json](https://github.com/markosluga/change-route53/blob/main/route53-stub.json) as well as the "TTL" value, which can be changed arbitrarily to the number of seconds you prefer.
