local base = import './base.libsonnet';

 base {
   components +: {
     app +: {
       "replicaCount": 1,
       "deploymentName": "d-webserver",
       "serviceName": "d-webserver",
       "port": 8585,
       "targetPort": 80,
       "nodePort": 30555
     },
  }
 }