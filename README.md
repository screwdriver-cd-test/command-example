# command-example
Screwdriver example for validating, publishing, and tagging a command

>Screwdriver v4 command for installing packages needed to perform AWS CLI commands

## Image
**This command requires `yum`, so the image you use with the command needs to have `yum` installed.**

## Usage
If no AWS default region is specified, it will default to using `us-west-2`.

Command:
```
sd-cmd exec awscli/install@1.0 -i <secret_key_id> -s <secret_access_key> -r <region>
```

This command uses yum to install the following packages.
- y-epel-release
- jq
- python34-pip
- awscli

After installing the above, this command sets your AWS credentials so you can run `aws` commands directly.
