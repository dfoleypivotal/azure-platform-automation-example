credhub set -n /concourse/dev/storage_account_key -t value -v '{
}'
credhub set -n /concourse/dev/db_password -t value -v 'terraform output pas_sql_password'
credhub set --type certificate --name '/concourse/dev/uaa_pem' --certificate /Users/dfoley/GCP/ControlPlane/dev.crt --private /Users/dfoley/GCP/ControlPlane/dev.key
credhub set -n /concourse/dev/credhub_key_encryption_password -t value -v 'SOME PASSWORD'
credhub set -n /concourse/dev/pivnet_token -t value -v 'PIVNET TOKEN'
credhub set -n /concourse/dev/git_private_key -t rsa -p ''
credhub set -n /concourse/dev/opsman_password -t value -v 'SOME PASSWORD'
credhub set -n /concourse/dev/opsman_decryption_passphrase -t value -v 'SOME PASSWORD'
credhub set -n /concourse/dev/state_bucket_key -t value -v '{
}'
credhub set -n /concourse/dev/opsman_service_account_json -t value -v '{
}'
