# Makefile mirrors the Jenkins stages for quick local tests


TF_DIR := terraform
ENV ?= dev


.PHONY: init fmt validate plan apply destroy outputs


init:
cd $(TF_DIR) && terraform init -input=false


fmt:
cd $(TF_DIR) && terraform fmt -recursive


validate:
cd $(TF_DIR) && terraform validate


plan:
cd $(TF_DIR) && terraform plan -var-file=env/$(ENV).tfvars -out=tfplan


apply:
cd $(TF_DIR) && terraform apply -auto-approve tfplan


destroy:
cd $(TF_DIR) && terraform destroy -auto-approve -var-file=env/$(ENV).tfvars


outputs:
cd $(TF_DIR) && terraform output