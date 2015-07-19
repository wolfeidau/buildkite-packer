AWS_ACCESS_KEY := $(AWS_ACCESS_KEY)
AWS_SECRET_KEY := $(AWS_SECRET_KEY)

build:
	packer build \
		-var 'aws_access_key=${AWS_ACCESS_KEY}' \
		-var 'aws_secret_key=${AWS_SECRET_KEY}' \
		buildkite-agent.json
