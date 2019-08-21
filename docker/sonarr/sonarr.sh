docker create \
  --name=sonarr \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=America/Denver \
  -p 8989:8989 \
  -v /home/juftin/docker/sonarr/config:/config \
  -v /media/juftin/NAS/Plex/'TV Shows':/tv \
  -v /media/juftin/NAS/Downloads:/downloads \
  --restart unless-stopped \
  linuxserver/sonarr
