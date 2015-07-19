# buildkite-packer

This project contains a simple [packer](https://www.packer.io/) configuration which builds an AMI for the [buildkite-agent](https://buildkite.com/docs/agent/installation) using [ubuntu](http://ubuntu.com) base image.

# usage

Update the `type`, `source_ami` and `region` in the `buildkite-agent.json`.

Ensure you have your `AWS_ACCESS_KEY` and `AWS_SECRET_KEY` exported as env variables then run.

```
make
```

# License

Released by Mark Wolfe under MIT license.
