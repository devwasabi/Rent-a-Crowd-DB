# AWS

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
