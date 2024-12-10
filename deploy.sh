helm install my-release \
  --set setGame=true \
  --set gameUrl=https://content.minetest.net/packages/Wuzzy/mineclone2 \
  --set cliArgs='--gameid mineclone2' \
  fermosit/minetest