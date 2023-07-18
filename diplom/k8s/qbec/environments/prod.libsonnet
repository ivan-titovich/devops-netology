local base = import './base.libsonnet';

 base {
   components +: {
     app +: {
       "replicaCount": 2,
       "deploymentName": "d-webserver",
       "serviceName": "d-webserver",
       "port": 8282,
       "targetPort": 80,
       "nodePort": 30666
     },
  }
 }