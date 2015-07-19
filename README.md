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

# License

Released by Mark Wolfe under MIT license.
