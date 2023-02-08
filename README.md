# NEWCATALOG

## Run containers

```
bash run.sh dev up
```


## Create dump DB

1. Start container

```
bash run.sh dev start
```

2. Go to the command line Docker container

```
docker exec -it newcatalog__service--db-main sh
```

3. Change user to "postgres"

```
su - postgres;
```

4. Create schema:

schema empty

```
pg_dump -h localhost -d newcatalog --schema-only -U postgres -W > /var/lib/postgresql/data/db-empty.sql
```

- or 

schema data

```
pg_dump -h localhost -d newcatalog -U postgres -W > /var/lib/postgresql/data/db-data.sql
```

5. Go to the command line of the local computer and copy the desired scheme (db-data.sql, db-empty.sql) to the local computer


schema empty

```
docker cp -a newcatalog__service--db-main:/var/lib/postgresql/data/db-empty.sql ./service--db-main/db-empty.sql
```

- or 

schema data

```
docker cp -a newcatalog__service--db-main:/var/lib/postgresql/data/db-data.sql ./service--db-main/db-data.sql
```

## DB
```
docker compose --env-file ./.env-dev down --volumes
```


docker cp newcatalog__service--admin:/app/newcatalog/service--admin/node_modules ./service--admin



docker rm -v newcatalog__service--db-main