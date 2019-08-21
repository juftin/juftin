docker create \
  --name=radarr \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=America/Denver \
  -p 7878:7878 \
  -v /home/juftin/docker/radarr/config:/config \
  -v /media/juftin/NAS/Plex/Movies:/movies \
  -v /media/juftin/NAS/Downloads:/downloads \
  --restart unless-stopped \
  linuxserver/radarr
