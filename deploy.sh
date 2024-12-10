helm install minetest-pg . \
  --set setGame=true \
  --set gameUrl=https://content.minetest.net/packages/Wuzzy/mineclone2 \
  --set cliArgs='--gameid mineclone2' \
  --set service.type='LoadBalancer'