AWS_ACCESS_KEY := $(AWS_ACCESS_KEY)
AWS_SECRET_KEY := $(AWS_SECRET_KEY)
AWS_REGION := $(AWS_REGION)
SOURCE_AMI := $(SOURCE_AMI)

build:
	packer build \
		-var 'aws_access_key=${AWS_ACCESS_KEY}' \
		-var 'aws_secret_key=${AWS_SECRET_KEY}' \
		-var 'aws_region=${AWS_REGION}' \
		-var 'source_ami=${SOURCE_AMI}' \
		buildkite-agent.json
