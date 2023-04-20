# Overview
A repo to compare tfsec, checkov, and terrascan

## Checkov

You can scan one file using:

```bash
checkof -f ec2.tf
```

Or scan an entire directory:

```bash
checkov -d .
```

## tfsec

To scan the current directory:
```bash
tfsec .
```

You can exclude certain checks by specifying the check ID as below:
```bash
tfsec . --exclude aws-s3-specify-public-access-block
```

To filter a certain check use the command below:
```bash
tfsec . --filter-results CUS999
```

## terrascan

