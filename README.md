# Terraform Infrastructure Setup

This repository contains Terraform configurations for setting up cloud infrastructure on AWS and GCP. The directory structure organizes Terraform files by provider and specific use cases.

## Directory Structure

```
.
├── buckets
│   ├── aws_s3
│   │   └── main.tf
│   └── gcp
│       └── main.tf
└── Getting_started
    ├── aws
    │   ├── main.tf
    │   ├── single_instance
    │   │   └── main.tf
    └── gcp
        ├── main.tf
        ├── single_instance
        │   └── main.tf
```

## Contents

### Buckets

- **AWS S3**
  - `main.tf`: Configuration file for setting up an S3 bucket on AWS.

- **GCP**
  - `main.tf`: Configuration file for setting up storage buckets on Google Cloud Platform.

### Getting Started

- **AWS**
  - `main.tf`: Main configuration file for initializing AWS resources.
  - **Single Instance**
    - `main.tf`: Configuration for setting up a single EC2 instance on AWS.

- **GCP**
  - `main.tf`: Main configuration file for initializing GCP resources.
  - **Single Instance**
    - `main.tf`: Configuration for setting up a single VM instance on GCP.

## Usage

### AWS

To deploy the AWS infrastructure, navigate to the desired directory and run the following commands:

1. Initialize Terraform:

   ```sh
   terraform init
   ```

2. Apply the configuration:

   ```sh
   terraform apply
   ```

### GCP

To deploy the GCP infrastructure, navigate to the desired directory and run the following commands:

1. Initialize Terraform:

   ```sh
   terraform init
   ```

2. Apply the configuration:

   ```sh
   terraform apply
   ```

## Notes

- Ensure you have the necessary cloud provider credentials configured before running Terraform commands.

---

