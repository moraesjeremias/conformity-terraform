data "conformity_external_id" "all" {}
data "conformity_external_id" "external" {}

resource "aws_cloudformation_stack" "personal_conformity" {
  name         = "CloudConformity"
  template_url = "https://s3-us-west-2.amazonaws.com/cloudconformity/CloudConformity.template"
  parameters = {
    AccountId  = var.account_id
    ExternalId = data.conformity_external_id.all.external_id
  }
  capabilities = ["CAPABILITY_NAMED_IAM"]
}

resource "conformity_aws_account" "aws" {
  name        = "aws-conformity"
  environment = "development"
  role_arn    = aws_cloudformation_stack.personal_conformity.outputs["CloudConformityRoleArn"]
  external_id = data.conformity_external_id.external.external_id
  tags        = ["development"]

  settings {
    rule {
      rule_id = "IAM-034"
      settings {
        enabled     = true
        risk_level  = "HIGH"
        rule_exists = true
        extra_settings {
          name = "identityProviders"
          type = "multiple-string-values"
          values { value = "mycompany_idp_test.firebaseapp.com" }
        }
      }
    }
  }
}