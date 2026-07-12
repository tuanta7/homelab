.PHONY: chmod-scripts

install-multipass-macos:
	curl -fL -o multipass.pkg https://canonical.com/multipass/download/macos
	sudo installer -pkg multipass.pkg -target /
	rm multipass.pkg

create-bridged-network:
	INTERFACE=$(INTERFACE) ./scripts/multipass/create-bridged-network.sh

create-k3s-server-instance:
	NAME=$(NAME) IMAGE=$(IMAGE) CPUS=$(CPUS) MEMORY=$(MEMORY) DISK=$(DISK) ./scripts/multipass/create-k3s-server-instance.sh

chmod-scripts:
	sudo chmod -R +x scripts

install-helm:
	./scripts/tools/install-helm.sh

install-go-linux:
	GO_VERSION=$(VERSION) ./scripts/tools/install-go-linux.sh

install-brew-linux:
	./install-brew-linux.sh

install-k3s-server:
	./scripts/install-k3s-server.sh

install-k3s-agent:
	K3S_URL=$(URL) K3S_TOKEN=$(TOKEN) ./scripts/install-k3s-agent.sh

install-argocd:
	./scripts/argocd/install.sh

setup-namespaces:
	./scripts/argocd/setup-namespaces.sh

get-argocd-admin-password:
	kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d


