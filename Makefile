.PHONY: chmod-scripts

install-multipass-macos: 
	curl -fL -o multipass.pkg https://canonical.com/multipass/download/macos
	sudo installer -pkg multipass.pkg -target /
	rm multipass.pkg

chmod-scripts:
	sudo chmod -R +x scripts

install-brew-linux:
	./install-brew-linux.sh

install-k3s-server:
	./scripts/install-k3s-server.sh

install-k3s-agent:
	K3S_URL=$(URL) K3S_TOKEN=$(TOKEN) ./scripts/install-k3s-agent.sh

install-argocd:
	./scripts/install-argocd.sh

setup-namespaces:
	./scripts/setup-namespaces.sh

get-argocd-admin-password:
	kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d


