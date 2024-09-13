# Overview

A repo to compare tfsec, checkov, and terrascan. Some of the Terraform code was taken from the [terragoat GitHub](https://github.com/bridgecrewio/terragoat/blob/master/terraform/aws/ec2.tf) repo and modified for illustration.

## Checkov

### Checkov General Overview

You can scan one file using:

```bash
checkov -f ./Terraform/ec2.tf
```

Or scan an entire directory:

```bash
checkov -d ./Terraform
```

To output in a specific format such as JSON:

```bash
checkov -d ./Terraform cle--output json
```

To scan for the Kubernetes framework run the following command:

```bash
checkov -d ./Kubernetes --framework kubernetes
```

Try again using the Bridgecrew trial with the API creds.

```bash
mv ~/credentials ~/.bridgecrew/
checkov -d ./Terraform
checkov -d ./Kubernetes --framework kubernetes
```

Finally you can check only the high and critical vulnerabilities by running:

```bash
checkov -d ./Terraform --check HIGH
```

> Note that is is only possible with an API key.

### Checkov Custom Policy

Now let's create a custom policy that ensures that an S3 bucket doesn't have an acl that is `public-read` and the tag is `Scope="PCI"`. You can check the file `Terraform/s3_pci.tf` which will violate our policy.

Examine the `S3PCIPrivateACL.py` python file where we define the policy and then run the command below:

```bash
checkov -f Terraform/s3_pci.tf --external-checks-dir Terraform/checkov_my_extra_checks --check CKV_AWS_999
```

> Notice that using the above command, we specified the exact check that we created with ID: CKV_AWS_999 using the `--check flag`

## tfsec

### tfsec General Overview

To scan the Terraform directory:

```bash
tfsec ./Terraform
```

To output in a JSON format use the following command:

```bash
tfsec ./Terraform --format json
```

You can exclude certain checks by specifying the check ID as below:

```bash
tfsec ./Terraform --exclude aws-s3-specify-public-access-block
```

### tfsec Custom Policy

Check the `pci_policy_tfchecks.yaml` in the `.tfsec` folder 

```bash
tfsec ./Terraform
```

## terrascan

### Terrascan General Overview

To scan a single file:

```bash
terrascan scan -f Terraform/s3.tf
```

To scan an entire directory:

```bash
terrascan scan -d ./Terraform
```

Now let's scan our Kubernetes folder

```bash
terrascan scan -d ./Kubernetes -i k8s
```

### Terrascan Custom Policy

We’ve included these 2 files in the `terrascan_custom_policy` folder in our repo under the `Terraform` folder.

```bash
terrascan scan --policy-path ./Terraform/terrascan_custom_policy --policy-path ~/.terrascan/pkg/policies/opa/rego
```

> Notice how we use the --policy-path to point to the directory where our custom rego policies live. The second --policy-path flag points to the general place where terrascan stores all its policies. If you omit the last --policy-path you will only run the scans for the custom policy that we created.
> 
