# NEWCATALOG


## Init

### Dev
1. git clone --recurse-submodules https://github.com/EvgeniySaschenko/newcatalog.git
2. cd newcatalog
3. bash run.sh dev init
4. bash run.sh dev up
5. bash run.sh dev build

### Prod
1. git clone --recurse-submodules https://github.com/{YOUR_REPOSITORY}.git
2. cd {YOUR_REPOSITORY}
3. bash run.sh prod init
4. bash run.sh prod stop
5. bash run.sh prod start

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
pg_dump -h localhost -d newcatalog --schema-only -U postgres -W > /var/lib/postgresql/data/1.db-empty.sql
```

- or 

schema data

```
pg_dump -h localhost -d newcatalog -U postgres -W > /var/lib/postgresql/data/1.db-data.sql
```

```
pg_dump -d newcatalog -t translations > /var/lib/postgresql/data/3.translations-data.sql
```

5. Go to the command line of the local computer and copy the desired scheme (db-data.sql, db-empty.sql) to the local computer


schema empty

```
docker cp -a newcatalog__service--db-main:/var/lib/postgresql/data/1.db-empty.sql ./service--db-main/1.db-empty.sql
```

- or 

schema data

```
docker cp -a newcatalog__service--db-main:/var/lib/postgresql/data/1.db-data.sql ./service--db-main/1.db-data.sql
```


```
docker cp -a newcatalog__service--db-main:/var/lib/postgresql/data/3.translations-data.sql ./service--db-main/3.translations-data.sql
```
docker cp -a newcatalog__service--proxy:/etc/ssl/ ./tmp
## DB
```
docker compose --env-file ./.env-dev down --volumes
```


docker cp newcatalog__service--admin:/app/newcatalog/service--admin/node_modules ./service--admin



docker rm -v newcatalog__service--db-main

## translations
```
In order for the regular expression to correctly extract the text of the translation function $t("text text text"), eslint uses the 'function-paren-newline' rule, this rule prevents the argument from wrapping to the next line.
```
```
In this case, the 'function-paren-newline' rule may conflict with prettier "printWidth" - because of this, the regex may not find all translation functions "$t".
```
```
To see eslint errors, you need to run "npm run lint" locally on your computer, I plan to change this later.
```

