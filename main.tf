module "service_llrt_a" {
  source = "./modules/lambda"

  lambda_name             = "lambda-llrt-terraform"
  environment_variables   = {}
  lambda_handler_location = "index.handler"
  lambda_source_dir       = "${path.module}/src"
  lambda_source_path      = "./src"
}
