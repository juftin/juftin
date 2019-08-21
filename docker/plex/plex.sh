docker create \
  --name=plex \
  --net=host \
  -e PUID=1000 \
  -e PGID=1000 \
  -e VERSION=docker \
  -v /home/juftin/docker/plex/config:/config \
  -v /media/juftin/NAS/Plex/'TV Shows':/data/tvshows \
  -v /media/juftin/NAS/Plex/Movies:/data/movies \
  -v /media/juftin/NAS/Plex/Transcoding:/transcode \
  --restart unless-stopped \
  linuxserver/plex
