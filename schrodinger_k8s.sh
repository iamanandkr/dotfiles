function k_dev_namespace() {
    kubectl get namespaces | grep $USER | awk '{print $1}'
}

function k_get_dev_pod() {
    kubectl get pods -n $(k_get_dev_namespace)
}

