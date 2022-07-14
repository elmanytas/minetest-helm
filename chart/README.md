# Minetest helm chart

Creates a minetest server in port 30000/udp by default in a kubernetes cluster.

## TL;DR;

```console
$ helm repo add fermosit https://harbor.fermosit.es/chartrepo/library
$ helm upgrade --install fermosit/minetest
```

## Introduction

This chart bootstraps a [Minetest](https://www.minetest.net/) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

It also allows to install [minetest games](https://content.minetest.net/packages/?type=game) on-the-fly.

Source code:  https://github.com/elmanytas/minetest-kubernetes

Report bugs here: https://github.com/elmanytas/minetest-kubernetes/issues

## Prerequisites

- Kubernetes 1.12+
- Helm 3
- PV provisioner support in the underlying infrastructure

## Installing the chart

To install the chart with the release name `my-release`:

```console
$ helm repo add fermosit https://harbor.fermosit.es/chartrepo/library
$ helm install my-release fermosit/minetest
```

The command deploys Minetest on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Installing games

Configure the var `setGame=true` and `gameUrl` to the game. Look for games in [https://content.minetest.net/packages/?type=game](https://content.minetest.net/packages/?type=game), copy url and install it.

Example:

```console
helm install my-release \
  --set setGame=true \
  --set gameUrl=https://content.minetest.net/packages/Wuzzy/mineclone2 \
  fermosit/minetest
```

## Landing page

Optional: creates a web page with instructions to connect this minetest server.

In GKE:
- service.type: LoadBalancer
- externalTrafficPolicy: Cluster
on-prem:
- service.type: ClusterIP

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters


The following table lists the configurable parameters of the Zabbix Server chart and their default values.

|            Parameter            |                                          Description                                             |                           Default                            |
| --------------------------------| ------------------------------------------------------------------------------------------------ | ------------------------------------------------------------ |
| `image.minetest.registry`       | Minetest image registry                                                                          | `docker.io`                                                  |
| `image.minetest.repository`     | Minetest image name                                                                              | `linuxserver/minetest`                                       |
| `image.minetest.tag`            | Minetest image tag                                                                               | `latest`                                                     |
| `image.minetest.pullPolicy`     | Minetest image pull policy                                                                       | `Always`                                                     |
| `image.minetest.pullSecrets`    | Minetest docker-registry secret names as an array                                                | `[]` (does not add image pull secrets to deployed pods)      |
| `image.httpd.registry`          | httpd image registry                                                                             | `docker.io`                                                  |
| `image.httpd.repository`        | httpd image name                                                                                 | `httpd`                                                      |
| `image.httpd.tag`               | httpd image tag                                                                                  | `latest`                                                     |
| `image.httpd.pullPolicy`        | httpd Image pull policy                                                                          | `IfNotPresent`                                               |
| `image.httpd.pullSecrets`       | httpd docker-registry secret names as an array                                                   | `[]` (does not add image pull secrets to deployed pods)      |
| `nameOverride.`                 | Strings to partially override fullname templates with a string (will prepend the release name)   | `nil`                                                        |
| `fullnameOverride.`             | Strings to fully override fullname templates with a string                                       | `nil`                                                        |
| `minetestPort`                  | Port to be exposed to the internet (30000 .. 32767)                                              | `30000`                                                      |
| `minetestTimezone`              | Timezone                                                                                         | `Europe/Madrid`                                              |
| `cliArgs`                       | Minetest cli arguments (example: `--gameid minetest`)                                            | `nil`                                                        |
| `backup`                        | Backup all data before minetest start                                                            | `false`                                                      |
| `setGame`                       | Configure game downloading/updating                                                              | `false`                                                      |
| `gameUrl`                       | Game url to be downloaded                                                                        | `https://content.minetest.net/packages/Wuzzy/mineclone2`     |
| `setOptions`                    | Configure minetest options                                                                       | `false`                                                      |
| `enableDamage`                  | Enable players getting damage and dying                                                          | `true`                                                       |
| `creativeMode`                  | Enable creative mode for new created maps.                                                       | `false`                                                      |
| `freeMode`                      | Player is able to fly without being affected by gravity. "fly" privilege on the server required. | `false`                                                      |
| `fastMode`                      | Fast movement (via the "special" key). This requires the "fast" privilege on the server.         | `true`                                                       |
| `autojump`                      | Automatically jump up single-node obstacles.                                                     | `true`                                                       |
| `tineSpeed`                     | Controls length of day/night cycle.                                                              | `72`                                                         |
| `service.type`                  | Service type                                                                                     | `ClusterIP`                                                  |
| `service.port`                  | Public UDP Port                                                                                  | `30000`                                                      |
| `service.externalTrafficPolicy` | Enable client source IP preservation                                                             | `Cluster`                                                    |
| `resources`                     | Configure resource requests and limits                                                           | `nil`                                                        |
| `nodeSelector`                  | Node labels for pod assignment                                                                   | `{}`                                                         |
| `tolerations`                   | List of node taints to tolerate                                                                  | `[]`                                                         |
| `affinity`                      | Map of node/pod affinities                                                                       | `{}`                                                         |
| `podAnnotations`                | Pod annotations                                                                                  | `{}`                                                         |
| `ingress.enabled`               | Set to true to enable ingress record generation to little instructions page                      | `false`                                                      |
| `ingress.hostname`              | Default host for the ingress resource                                                            | `localhost`                                                  |
| `ingress.annotations`           | Ingress annotations                                                                              | `[]`                                                         |
| `persistence.accessMode`        | PVC Access Mode                                                                                  | `ReadWriteOnce`                                              |
| `persistence.size`              | PVC Storage Request                                                                              | `100Mi`                                                      |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
helm repo add fermosit https://harbor.fermosit.es/chartrepo/library
helm upgrade --install minetest fermosit/minetest \
  --namespace minetest \
  --set persistence.size=2Gi
```

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```console
$ helm upgrade --install --name my-release -f values.yaml fermosit/minetest
```

> **Tip**: You can use the default [values.yaml](values.yaml)

