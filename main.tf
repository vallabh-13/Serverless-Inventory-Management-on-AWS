provider "aws" {
  region = var.aws_region
}

module "dynamodb" {
  source       = "./modules/dynamodb"
  table_name   = var.dynamodb_table_name
  environment  = var.environment
  project_name = var.project_name
}

module "iam" {
  source              = "./modules/iam"
  lambda_role_name    = var.lambda_role_name
  dynamodb_table_arn  = module.dynamodb.table_arn
}

module "lambda_get" {
  source              = "./modules/lambda"
  function_name       = "get_coffee"
  lambda_role_arn     = module.iam.lambda_role_arn
  lambda_handler      = "index.handler"
  lambda_runtime      = "nodejs20.x"
  lambda_zip_path     = "${path.module}/lambda/get_coffee.zip"
  dynamodb_table_name = module.dynamodb.table_name
  environment         = var.environment
  project_name        = var.project_name
}

module "lambda_post" {
  source              = "./modules/lambda"
  function_name       = "post_coffee"
  lambda_role_arn     = module.iam.lambda_role_arn
  lambda_handler      = "index.handler"
  lambda_runtime      = "nodejs20.x"
  lambda_zip_path     = "${path.module}/lambda/post_coffee.zip"
  dynamodb_table_name = module.dynamodb.table_name
  environment         = var.environment
  project_name        = var.project_name
}

module "lambda_put" {
  source              = "./modules/lambda"
  function_name       = "put_coffee"
  lambda_role_arn     = module.iam.lambda_role_arn
  lambda_handler      = "index.handler"
  lambda_runtime      = "nodejs20.x"
  lambda_zip_path     = "${path.module}/lambda/put_coffee.zip"
  dynamodb_table_name = module.dynamodb.table_name
  environment         = var.environment
  project_name        = var.project_name
}

module "lambda_delete" {
  source              = "./modules/lambda"
  function_name       = "delete_coffee"
  lambda_role_arn     = module.iam.lambda_role_arn
  lambda_handler      = "index.handler"
  lambda_runtime      = "nodejs20.x"
  lambda_zip_path     = "${path.module}/lambda/delete_coffee.zip"
  dynamodb_table_name = module.dynamodb.table_name
  environment         = var.environment
  project_name        = var.project_name
}

module "cloudwatch" {
  source                = "./modules/cloudwatch"
  lambda_function_names = [
    module.lambda_get.lambda_function_name,
    module.lambda_post.lambda_function_name,
    module.lambda_put.lambda_function_name,
    module.lambda_delete.lambda_function_name
  ]
  log_retention_days = var.log_retention_days
  environment        = var.environment
  project_name       = var.project_name
}

module "api_gateway" {
  source          = "./modules/api_gateway"
  api_gateway_name = var.api_gateway_name
  api_stage_name   = var.api_stage_name
  region           = var.aws_region
  account_id       = var.aws_account_id
  lambda_methods = {
    GET    = module.lambda_get.lambda_function_arn
    POST   = module.lambda_post.lambda_function_arn
    PUT    = module.lambda_put.lambda_function_arn
    DELETE = module.lambda_delete.lambda_function_arn
  }
}

module "amplify" {
  source          = "./modules/amplify"
  app_name        = var.amplify_app_name
  github_repo_url = var.github_repo_url
  github_token    = var.github_token
  branch_name     = var.branch_name
  api_gateway_url = module.api_gateway.api_endpoint
  frontend_path   = var.frontend_path
  environment     = var.environment
  project_name    = var.project_name

  depends_on = [module.api_gateway]
}
