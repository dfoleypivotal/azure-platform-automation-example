#!/bin/bash -e
pivnet download-product-files  -p p-control-plane-components -r 0.0.31 -i 349108
pivnet download-product-files  -p p-control-plane-components -r 0.0.31 -i 349107
pivnet download-product-files  -p p-control-plane-components -r 0.0.31 -i 349106
pivnet download-product-files  -p p-control-plane-components -r 0.0.31 -i 349105
pivnet download-product-files  -p p-control-plane-components -r 0.0.31 -i 349103
pivnet download-product-files  -p p-control-plane-components -r 0.0.31 -i 352796

# Downloasd azure stremcell
pivnet download-product-files  -p stemcells-ubuntu-xenial -r 250.17 -i 324379

# 
export BOSH_CLIENT=ops_manager
export BOSH_ENVIRONMENT=10.0.8.10
export BOSH_CLIENT_SECRET=<Your BOSH Client Secret>
export BOSH_CA_CERT=/var/tempest/workspaces/default/root_ca_certificate

bosh upload-stemcell *bosh-stemcell*.tgz
bosh upload-release concourse-release-*.tgz
bosh upload-release credhub-release-*.tgz
bosh upload-release garden-runc-release-*.tgz
bosh upload-release postgres-release-*.tgz
bosh upload-release uaa-release-*.tgz
