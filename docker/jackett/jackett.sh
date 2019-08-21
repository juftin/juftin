docker create \
  --name=jackett \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=America/Denver \
  -p 9117:9117 \
  -v /home/juftin/docker/jackett/config:/config \
  -v /home/juftin/Documents/Media/`Torrent Files`:/downloads \
  --restart unless-stopped \
  linuxserver/jackett
