# This script installs the Terraform Version Manager and the Terraform
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
mkdir ~/bin
ln -s ~/.tfenv/bin/* ~/bin/
tfenv install

# Clone the automation script repository
git clone https://github.com/wirjo/databricks-aws-workshop-setup.git
cd ./databricks-aws-workshop-setup/
cp .env.template .env 

# Edit the configuration as per the README using vi text editor
vi .env 