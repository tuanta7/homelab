.PHONY: chmod-scripts

install-multipass-macos: 
	curl -fL -o multipass.pkg https://canonical.com/multipass/download/macos
	sudo installer -pkg multipass.pkg -target /
	rm multipass.pkg

install-brew-linux:
	./install-brew-linux.sh

chmod-scripts:
	sudo chmod -R +x scripts


## Run on multipass instances 
install-k3s-server:
	./scripts/install-k3s-server.sh

install-argocd:
	./scripts/install-argocd.sh

get-argocd-admin-password:
	