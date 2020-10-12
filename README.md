# Minetest helm chart

Creates a minetest server in port 30000/udp by default in a server with [k3s](https://k3s.io/).

Optional: creates a web page with instructions to connect this minetest server.

In GKE:
- service.type: LoadBalancer
- externalTrafficPolicy: Cluster
on-prem:
- service.type: ClusterIP
