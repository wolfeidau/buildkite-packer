# buildkite-packer

This project contains a simple [packer](https://www.packer.io/) configuration which builds an AMI for the [buildkite-agent](https://buildkite.com/docs/agent/installation) and [docker](https://www.docker.com/), using [ubuntu](http://ubuntu.com) as the base image.

# usage

Update the `type`, `source_ami` and `region` in the `buildkite-agent.json`.

Ensure you have your `AWS_ACCESS_KEY` and `AWS_SECRET_KEY` exported as env variables then run.

```
make
```

To use the AMI, when setting up a new EC2 host use the following `user-data`.

```bash
#!/bin/bash
sed -i "s/xxx/YOUR_KEY_HERE/g" /etc/buildkite-agent/buildkite-agent.cfg
service buildkite-agent start
```

# Using Coffer for Secrets

Optionally user [coffer](https://github.com/wolfeidau/coffer) to download credentials.

Make a bundle which contains your SSH key.

```yaml
files:
  "/var/lib/buildkite-agent/.ssh/id_rsa":
    mode: 0600
    content: |
        -----BEGIN RSA PRIVATE KEY-----
        XXXX
        -----END RSA PRIVATE KEY-----
```

Upload it to your S3 bucket, note that you need to generate a secret to encrypt the contents of the coffer, this should be ~20 characters long.

```
coffer --coffer-file buildkite.coffer --secret YOUR_SECRET_HERE upload --bucket="XXXX-coffers"
```

Make an IAM role for your buildkite-agents so they can read from the bucket containing your coffer files. You will assign this role to the EC2 host when you create it.

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:Get*",
                "s3:List*"
            ],
            "Resource": [
                "arn:aws:s3:::XXXX-coffers/*"
            ]
        }
    ]
}
```

Add this line to the `user-data` script.

```
su - buildkite-agent -c "AWS_REGION=us-west-2 coffer --coffer-file buildkite.coffer --secret XXXX download-sync --bucket=XXXX-coffers"
```

# License

Released by Mark Wolfe under MIT license.
