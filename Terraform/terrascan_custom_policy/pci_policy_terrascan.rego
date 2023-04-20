package accurics

{{.prefix}}{{.name}}{{.suffix}}[array.id] {
	array := input.aws_s3_bucket[_]
	array.config.acl == "public-read"
	array.config.tags == {"Scope": "PCI"}
}
