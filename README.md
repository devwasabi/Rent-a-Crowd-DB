# AWS
To get the necessary parts of AWS is quite an endeavour, as much of what goes into it has to be set up in the management console.

To begin, we will set up an S3 bucket for Terraform to use to store the state of the deployed system. You can give this any name, as long as you know what it is. This has to be set in `terraform/backend.tf`, and the default settings are fine.

If you are running this entirely locally, you won't need to setup the roles and indentity provider, if you give yourself administrator access. But I'm not here to tell you about that, as we need to get this to run on GitHub!

Firstly, we need to set up an identity provider in IAM for GitHub actions. Following [this guide given by Rudolph](https://aws.amazon.com/blogs/security/use-iam-roles-to-connect-github-actions-to-actions-in-aws/) we can ensure we set up the Identity Provider and a basic role that has no permissions.
At the section **To scope the trust policy (IAM console)**, we instead used a "StringLike" to allow access to all our branches, as this made our development easier. In production, you would set a specific branch that can access AWS.

Then, permissions for the roles... We set up two of our own policies, and used two Amazon defined policies: `AmazonRDSFullAccess` and `SecretsManagerReadWrite`. Furthermore, we created a role for KMS to allow decryption and encryption of the S3 contents, and a role for S3 specifically to allow access only to a specific bucket.

#### KMS
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "kms:ListKeys",
                "kms:Decrypt",
                "kms:TagResource",
                "kms:UntagResource",
                "kms:Encrypt",
                "kms:GenerateDataKey",
                "kms:DescribeKey"
            ],
            "Resource": "*"
        }
    ]
}
```

#### S3
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Statement1",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::rentacrowd-tfstate/*",
                "arn:aws:s3:::rentacrowd-tfstate"
            ]
        }
    ]
}
```

Finally, in our security group settings, we allowed port 1433 as an Ingress port for both IPv4 and IPv6 to ensure we can access the database as necessary via Flyway and our database managers.

Note: We are aware that the database is relatively unsecured, but the shifting of IP addresses and short timeline has made investigating further networking hardening difficult for our project.

# Terraform
This section will assume that you've created the role or are logged in as an admin locally (and that you have Terraform installed).

The steps to applying Terraform locally are quite simple, and each of the pieces will be able to alert you to if you have done something wrong.

```sh
terraform init
terraform plan
terraform apply
```

`terraform init` will require you to be logged in, have created the S3 bucket that you have named in `terraform/backend.tf`.
If you are attempting to run this locally, you should add `provider = <profile name>` just after the first line of `terraform/provider.tf`, where `<profile name>` references a profile in the AWS command line tool. 
For us grads, we only get adminstrator access as an option, so presumably you might have to check your permissions.

The mostly likely place that your setup will break is in `terraform apply`, if you don't have the necessary permissions. 
Please refer back to the AWS section to ensure that you do have everything needed. 
Otherwise, once it's started running for over 30 seconds, there's a good chance that everything is correct, and you just need to wait out the next 20 minutes while Terraform creates the database.


## Deployment requirements:
* Database on AWS cloud
* You can use any free tier relational database, or SQL Server on AWS
* No serverless databases
* AWS infrastructure deployment scripted (i.e. terraform, AWS cloud formation, AWS CDK)
* Deployment of database and database changes using a database change management tools like Flyway or Liquibase (only SQL allowed, no custom formats, choose your tool accordingly)
* Deployment automated (CI/CD)
 
## System Requirements:
* At least 5 tables populated with data
* At least 1 view, one proc, one scalar function and one table valued function
* These features need to have clear business use-cases to support creating them (i.e. QuarterlyReportisngView would be used to generate quarterly reports).
* As normalized as makes sense for your system.
 
## Deliverables
* Deployed database
* Source code in a git repo which ATC has access to
* Database design documentation (ERD)  in source control
* Infrastructure as code, source controlled
* Database change management code, source controlled
* CI/CD source controlled
* Complete readme on how to set up the working database from scratch, source controlled
* JIRA board tracking project progress
* Confluence pages for documentation
 
## Extra credit:
* Unit testing of your database
