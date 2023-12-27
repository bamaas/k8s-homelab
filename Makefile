.PHONY: all $(MAKECMDGOALS)

SHELL := /bin/bash
USER=root
MANAGER_NODE_IP?=$(shell sops --decrypt ./inventory.enc.yaml | grep k8s-manager-01 -A 1 | grep ansible_host | cut -d':' -f2- | tr -d ' ')
RESTORE=./.restore ${USER} ${MANAGER_NODE_IP}
INSTALL=./.install ${USER} ${MANAGER_NODE_IP}
BASENAME=$(shell basename ${PWD})

help:           																## Show this help
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/:.*##/;/' | column -t -s';'

rsync_up:																		## Sync to management node
	rsync -azvP --exclude '.git' --delete . ${USER}@${MANAGER_NODE_IP}:~/${BASENAME}

download_kubeconfig:															## Download kubeconfig from management node to localhost
	rsync -avq ${USER}@${MANAGER_NODE_IP}:~/.kube/config kubeconfig.yaml

install:																		## Install any component 
	${INSTALL} ${COMPONENT}

install_foundation:																## Install foundation
	${INSTALL} host-dns
	${INSTALL} rke2

install_tool:																	## Install a single tool
	${INSTALL} ${TOOL}

install_tools:																	## Install all tools
	${INSTALL} helm
	${INSTALL} helm-secrets
	${INSTALL} sops
	${INSTALL} azure-cli
	${INSTALL} jq
	${INSTALL} k9s
	${INSTALL} kubectl
	${INSTALL} velero-cli

install_app:																	## Install a single app
	${INSTALL} ${APP}

install_ephemeral_apps:															## Install all ephemeral applications
	${INSTALL} cert-manager
	${INSTALL} nfs-subdir-external-provisioner
	${INSTALL} minio
	${INSTALL} velero
	${INSTALL} longhorn
	${INSTALL} drone-runner-kube

install_stateful_apps:															## Install stateful applications
	${INSTALL} gitea
	${INSTALL} gotify
	${INSTALL} drone

install_apps: install_ephemeral_apps install_stateful_apps

restore_namespace:																## Restore namespace
	${RESTORE} ${NAMESPACE}

backup_cluster:																	## Create full backup from schedule including data
	./.backup ${USER} ${MANAGER_NODE_IP}

backup_namespace:																## Backup a namespace including data
	ssh ${USER}@${MANAGER_NODE_IP} \
	velero backup create ${BACKUP_NAME} \
	--include-namespaces=${NAMESPACE} \
	--default-volumes-to-restic=true


disaster_recovery: install_foundation install_tools	install_ephemeral_apps		## Full recovery in case of a disaster
	sleep 60
	${RESTORE} gitea
	${RESTORE} gotify
	${RESTORE} drone
	${RESTORE} acc
	${RESTORE} prd
# Restored but differently
# ${RESTORE} argocd is not included in the with data backup. use the without data one.

clean_install: install_foundation install_tools	install_apps					## Full installation from scratch