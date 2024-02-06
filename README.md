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
