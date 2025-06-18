module helmToCluster1 './module/helmdeployment.bicep' = {
  name: 'deployToCluster1'
  params: {
    aksClusterName: 'aks-prod-cluster'
    aksResourceGroup: 'rg-prod'
    releaseName: 'myapp'
    chartPath: './charts/myapp'
    namespace: 'app'
    values: {
      image: {
        repository: 'myacr.azurecr.io/myapp'
        tag: 'v1.0.0'
      }
    }
  }
}

module helmToCluster2 './module/helmdeployment.bicep' = {
  name: 'deployToCluster2'
  params: {
    aksClusterName: 'aks-dr-cluster'
    aksResourceGroup: 'rg-dr'
    releaseName: 'myapp'
    chartPath: './charts/myapp'
    namespace: 'app'
    values: {
      image: {
        repository: 'myacr.azurecr.io/myapp'
        tag: 'v1.0.0'
      }
    }
  }
}
