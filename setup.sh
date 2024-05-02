# This script installs the Terraform Version Manager and the Terraform
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
mkdir ~/bin
ln -s ~/.tfenv/bin/* ~/bin/
tfenv install

# Clone the automation script repository
git clone https://github.com/wirjo/databricks-aws-workshop-setup.git
cd ./databricks-aws-workshop-setup/
cp .env.template .env 
cp config/instructors.yml.template config/instructors.yml
cp config/students.yml.template config/students.yml