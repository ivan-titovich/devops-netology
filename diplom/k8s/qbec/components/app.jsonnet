local p = import '../params.libsonnet';
local params = p.components.app;

[
{
  "apiVersion": "apps/v1",
  "kind": "Deployment",
  "metadata": {
    "labels": {
      "app": "d-webserver"
    },
    "name": params.deploymentName
  },
  "spec": {
    "replicas": params.replicaCount,
    "selector": {
      "matchLabels": {
        "app": "d-webserver"
      }
    },
    "template": {
      "metadata": {
        "labels": {
          "app": "d-webserver"
        }
      },
      "spec": {
        "containers": [
          {
            "image":  params.image.repository+':'+params.image.tag,
            "imagePullPolicy": "Always",
            "name": "d-webserver",
            "ports": [
              {
                "containerPort": params.port
              }
            ]
          }
        ]
      }
    }
  }
},
{
  "apiVersion": "v1",
  "kind": "Service",
  "metadata": {
    "name": params.serviceName
  },
  "spec": {
    "ports": [
      {
        "name": "web",
        "port": params.port,
        "targetPort": params.targetPort,
        "nodePort": params.nodePort,
      }
    ],
    "selector": {
      "app": "d-webserver"
    },
    "type": "NodePort"
  }
}

]