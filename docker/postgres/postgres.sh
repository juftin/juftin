docker create \
        --name postgres \
        --network postgres-bridge \
        --user 1000:1000 \
        -e POSTGRES_USER=juftin \
        -e POSTGRES_PASSWORD=juftin_postgres \
        -e POSTGRES_DB=juftin \
        -e PGCLIENTENCODING=UTF8 \
        -e TZ=America/Denver \
        -v /home/juftin/docker/postgres/config:/var/lib/postgresql/data \
        -p 5432:5432 \
        --restart unless-stopped \
        postgres:latest
