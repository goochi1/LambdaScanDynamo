Dyanmo scan and save to s3
===========

A terraform to create an s3 and lambda function in AWS to scan a dynamo tabel and save content to s3.


Module Input Variables
----------------------

- `bucket name` - bucket name 
- `tabel name` - tabel name you want to copy
- `profile` - profile to allow access to aws account


Usage
----------------------
- Change bucket name in main.tf
- Change tabel name in main.tf
- Change bucket name in manifest.tf
- Change Profile in backend and main
- Change tf state bucket in backen