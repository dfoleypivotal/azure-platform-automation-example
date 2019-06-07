mkdir apps
cd apps
wget https://github.com/pivotal-cf/pivnet-cli/releases/download/v0.0.58/pivnet-linux-amd64-0.0.58
mv pivnet-linux-amd64-0.0.58 pivnet
chmod +x pivnet
export PATH=$PATH:~/apps
export PIVNET_API_TOKEN=<Your PivNet API Token>
pivnet login --api-token $PIVNET_API_TOKEN
