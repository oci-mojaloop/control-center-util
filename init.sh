#echo "https://${PRIVATE_REPO_USER}:${PRIVATE_REPO_TOKEN}@github.com" > ~/.gitcredentials.store
#git config --global credential.helper 'store --file ~/.gitcredentials.store'
#git config --global advice.detachedHead false
git clone https://github.com/infitx-org/iac-modules.git
cd iac-modules
git checkout $IAC_MODULES_TAG