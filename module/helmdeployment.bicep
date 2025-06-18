param aksClusterName string
param aksResourceGroup string
param namespace string = 'default'
param releaseName string
param chartPath string
param values object = {}

resource helmDeploy 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'helm-deploy-${uniqueString(aksClusterName, releaseName)}'
  location: resourceGroup().location
  kind: 'AzureCLI'
  properties: {
    azCliVersion: '2.40.0'
    timeout: 'PT30M'
    cleanupPreference: 'OnSuccess'
    retentionInterval: 'P1D'
    // forceUpdateTag: utcNow()
    environmentVariables: [
      {
        name: 'AKS_CLUSTER'
        value: aksClusterName
      }
      {
        name: 'AKS_RG'
        value: aksResourceGroup
      }
    ]
    scriptContent: '''
      az aks get-credentials --resource-group $AKS_RG --name $AKS_CLUSTER --overwrite-existing

      helm upgrade --install ${releaseName} ${chartPath} \
        --namespace ${namespace} \
        --create-namespace \
        --values '${jsonString(values)}'
    '''
  }
}
