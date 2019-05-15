export OM_TARGET=$(terraform output ops_manager_dns)
export OM_USERNAME=admin
export OM_PASSWORD=$(terraform output ops_manager_password)
