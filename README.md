# Jenkins Pipeline EC2 Web Server

## Project Overview
This project highlights how DevOps/Cloud Engineers design pipelines that:
- Enforce infrastructure standards with `terraform fmt` and `validate`.
- Provide **safe previews** using `terraform plan`.
- Enable **automated deployments** via `terraform apply`.
- Support clean tear-downs using `terraform destroy`.
- Parameterize environments (e.g., `dev`, `prod`) with `tfvars`.


After deployment, navigating to the EC2 public IP/DNS shows a landing page served by nginx.

## Prerequisites
- **AWS Account** with an IAM user/role that can manage EC2 and security groups.
- **Jenkins** instance with:
  - Docker (to run Terraform inside a container), or Terraform installed directly.
  - [AWS Credentials Plugin](https://plugins.jenkins.io/aws-credentials/).
  - A configured AWS credential with ID `aws-jenkins-creds`.

## Running the Pipeline
1. In Jenkins, create a **Multibranch Pipeline** or **Pipeline job** pointing to the repo.
2. Configure credentials: add AWS creds with ID `aws-jenkins-creds`.
3. Build with parameters:
   - **ACTION** → `plan`, `apply`, or `destroy`
   - **ENV** → `dev` or `prod`
   - **AWS_REGION** → e.g. `us-east-1`

4. After `apply`, the Jenkins console will display the public IP/DNS of the EC2 instance.

## Local Testing (Terraform)
For quick iteration, you can use Terraform or the included Makefile.

```bash
cd terraform
terraform init
terraform plan -var-file=env/dev.tfvars -out=tfplan
terraform apply -auto-approve tfplan
```

## Local Testing (Makefile)
```bash
make init fmt validate plan ENV=dev
make apply
```
