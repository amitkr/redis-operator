#!/usr/bin/env bash

set -o errexit
set -o nounset

src=./cmd/redisoperator
out=./bin/redis-operator

if [[ -n ${TARGETOS:-} ]] && [[ -n ${TARGETARCH:-} ]];
then
    echo "Building ${TARGETOS}/${TARGETARCH} release..."
    export GOOS=${TARGETOS}
    export GOARCH=${TARGETARCH}
    binary_ext=-${TARGETOS}-${TARGETARCH}
else
    echo "Building native release..."
fi

final_out=${out}${binary_ext:-}
ldf_cmp="-w -extldflags '-static'"
f_ver="-X main.Version=${VERSION:-dev}"

# kind get kubeconfig
# export KUBERNETES_SERVICE_HOST=https://127.0.0.1
# export KUBERNETES_SERVICE_PORT=44471

# oc get service alt -o yaml
# export KUBERNETES_SERVICE_HOST=10.96.88.130
# export KUBERNETES_SERVICE_PORT=31835

echo "Building binary at ${final_out}"
[ -x "${final_out}" ] || CGO_ENABLED=0 go build -o "${final_out}" --ldflags "${ldf_cmp} ${f_ver}"  "${src}"
