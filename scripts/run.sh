#!/bin/sh

./scripts/build.sh && ./bin/redis-operator --kubeconfig="${HOME}/.kube/config"
