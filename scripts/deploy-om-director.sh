#!/bin/bash

set -e

export SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

export director_bosh_root_storage_account=$(terraform output bosh_root_storage_account)
export director_client_id=$(terraform output client_id)
export director_client_secret=$(terraform output client_secret)
export director_default_security_group_name=$(terraform output bosh_deployed_vms_security_group_name)
export director_resource_group_name=$(terraform output pcf_resource_group_name)
export director_ops_manager_ssh_public_key=$(terraform output ops_manager_ssh_public_key)
export director_ops_manager_ssh_private_key=$(terraform output ops_manager_ssh_private_key)
export director_subscription_id=$(terraform output subscription_id)
export director_tenant_id=$(terraform output tenant_id)
export director_network=$(terraform output network_name)
export director_subnetwork=$(terraform output infrastructure_subnet_name)
export director_internal_cidr=$(terraform output infrastructure_subnet_cidr)
export director_reserved_ip_ranges="10.0.8.1-10.0.8.9"
export director_internal_gw=$(terraform output infrastructure_subnet_gateway)
export director_dns_servers="168.63.129.16,8.8.8.8"

source $SCRIPT_DIR/set-om-creds.sh

echo "Configuring Ops Manager Authentication"
om -t $OM_TARGET --skip-ssl-validation \
  configure-authentication \
    --decryption-passphrase pivotal123 \
    --username admin \
    --password pivotal123

echo "Configuring Ops Manager Director"
om -t $OM_TARGET --skip-ssl-validation \
  configure-director --config $SCRIPT_DIR/director.yml --vars-env=director

echo "Deploying Ops Manager Director"
om -t $OM_TARGET --skip-ssl-validation apply-changes
