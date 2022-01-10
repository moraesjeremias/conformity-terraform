resource "conformity_profile" "profile_settings" {

  // add the profile_id , this values needs to be set if you want to overwrite an existing profile during terraform creation
  name       = "aws-conformity TEST ENV"

  // Optional | type : string
  description = "conformity development - rules included"

  included {
    id         = "IAM-034"
    provider   = "aws"
    enabled    = true
    risk_level = "HIGH"
    extra_settings {
      name = "identityProviders"
      type = "multiple-string-values"
      values { value = "mycompany_idp_test.firebaseapp.com" }
      values { value = "moraesjeremias.com.br" }
      values { value = "fake_idp_provider.com" }
      values { value = "fake_idp_provider_PROFILE_TEST.com" }
    }
  }

}

output "profile" {
  value = conformity_profile.profile_settings
}