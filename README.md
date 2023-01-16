## Dyn-route53 

#### A scripted alternative to dynamic DNS services

This script updates a public Route 53 record with a public dynamic IP address that is assigned to your instance or device. For example, this script could run on an EC2 instance with a public IP attached and detect the change to the public IP and change a DNS record assigned to it to the desired value. This script can be used to the need to use an Elastic IP. Alternatively, this script can run on any device that has a dynamic IP assigned and needs to be accessed by a known FQDN at all times.

### Configure your scripts

1. Reaplace the zone ID ```YOURZONEIDGOESHERE``` value with your zone id, which can be found in the AWS Route53 managemnt console and consists of upercase characters and numbers in:
     * line 7 of the "Resource" value in [iam-policy.json](https://github.com/markosluga/Dyn-route53/blob/main/iam-policy.json).
     * line 10 of the aws route53 cli command in [update-route53.sh](https://github.com/markosluga/change-route53/blob/main/update-route53.sh). This will be the script for the cron job.
2. Replace the ```replace.withyour.fqdn``` record string with the fqdn record you are going to be changing in:
     * line 11 of the [iam-policy.json](https://github.com/markosluga/Dyn-route53/blob/main/iam-policy.json) sample file
     * line 3 as the target of the dig command in [update-route53.sh](https://github.com/markosluga/change-route53/blob/main/update-route53.sh) script.
     * line 6 as the value for the "Name" key in [route53-stub.json](https://github.com/markosluga/change-route53/blob/main/route53-stub.json) stub file.

Additionally, you are welocme to change the "Type" value in in [route53-stub.json](https://github.com/markosluga/change-route53/blob/main/route53-stub.json) as well as the "TTL" value, which can be changed arbitrarily to the number of seconds you prefer, or add any other values as per the [AWS route53 CLI documentation](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/route53/change-resource-record-sets.html).

#### On EC2

3. Create and attach the policy to the role of your EC2 instance and install the latest [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html). Copy the [update-route53.sh](https://github.com/markosluga/change-route53/blob/main/update-route53.sh) script and [route53-stub.json](https://github.com/markosluga/change-route53/blob/main/route53-stub.json) stub file to your desired location (example in cron below is /home/user/)

#### Not on EC2

3. Create and attach the policy to an IAM user that will be used to call the aws cli. Retrieve the accesses key ID and secret key for the user. Install the latest [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) and configure it with the accesses key ID and secret key. Copy the [update-route53.sh](https://github.com/markosluga/change-route53/blob/main/update-route53.sh) script and [route53-stub.json](https://github.com/markosluga/change-route53/blob/main/route53-stub.json) stub file to your desired location (example in cron below is /home/user/)

### Configure crontab

Create a cron job that runs the job based on your IP address change time. For example if your address tends to change at midnight, running the job at 0:05 hours will do the trick. In this case you can run
```
crontab -e 
```
and add the following line to the job:
```
    5 0 * * * /home/user/update-route53.sh
```
Feel free to also configure the cron job to run on startup:
```
@reboot  /home/user/update-route53.sh
```
Make sure to point the job to where your [update-route53.sh](https://github.com/markosluga/change-route53/blob/main/update-route53.sh) script and [route53-stub.json](https://github.com/markosluga/change-route53/blob/main/route53-stub.json) stub file reside.
