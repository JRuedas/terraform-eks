# Master Universitario en Desarrollo y Operaciones (DevOps)

## TFM Terraform AKS

It contains terraform source code to create the base infrastructure and the deployment of the base apps.

It will provision the following components:
- Azure Resource Group
- Azure Kubernetes Cluster
- Azure DNS zone
- Azure Key Vault
    - Cert manager secret
    - External DNS secret

It will deploy the base apps:
- Argo CD. It will be in charge of deploying and managing the apps from [TFM Argo CD apps](https://github.com/JRuedas/tfm-terraform-k8s).
- Cert-manager. It's installed as a workaround to prevent leaking the DNS credentials through the `values.yaml` of the `Issuer/ClusterIssuer` because the CRDs didn't allow to reference an existing secret. I created the issue (https://github.com/cert-manager/cert-manager/issues/5412)