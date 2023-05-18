env=$1
mode=$2

source ./.env-$env

# delete local dir
# $1 - sevice dir
# $2 - target dir
function funDeleteDirLocal {
  local path_dir="./$1/$2"
  if [ -d $path_dir ]; then
    local result=$(rm -rf -R $path_dir) && local isDelete=true
    echo "$result"
    if [ "$isDelete" != true ]; then
      exit
    fi
    echo '--> Delete service:' "$1", dir local: "$2"
  fi
}

# copy to local dir
# $1 - sevice dir
# $2 - target dir
function funCopyDirFromContainer {
  local result=$(docker cp -a "${PROJECT_NAME}__$1:${WORKDIR_BASE}/$1/$2" "./$1") && local isCopy=true
  echo "$result"
  if [ "$isCopy" != true ]; then
    exit
  fi
  echo '--> Copy service:' "$1",  dir local: "$2"
}

# Init
function funInit {
  echo '--> Init - start'

  # 1. Containers are created to receive node_modules
  docker compose -f docker-node-modules.yml --env-file ./.env-${env} create

  # 2. node_modules are copied from the docker to the local computer, this is necessary for "EsLint", TypeScript, etc. to work.

  # ADMIN
  funDeleteDirLocal $ADMIN__SERVICE "node_modules"
  funCopyDirFromContainer $ADMIN__SERVICE "node_modules"

  # API
  funDeleteDirLocal $API__SERVICE "node_modules"
  funCopyDirFromContainer $API__SERVICE "node_modules"

  # SITE
  funDeleteDirLocal $SITE__SERVICE "node_modules"
  funCopyDirFromContainer $SITE__SERVICE "node_modules"

  # 3. Other containers are created.
  docker compose -f docker-compose.yml --env-file ./.env-${env} create
  docker compose -f docker-compose.yml --env-file ./.env-${env} start

  # local result2=$(docker compose --env-file ./.env-${env} up) && local isBuild2=true
  # echo "$result2"
  # if [ "$isBuild2" != true ]; then
  #   exit
  # fi
}

# Build
function funBuild {
  echo '--> Build - start'
  funDeleteDirLocal $ADMIN__SERVICE "dist"
  funDeleteDirLocal $SITE__SERVICE ".output"

  docker compose -f docker-build.yml --env-file ./.env-${env} up
  # ADMIN
  funCopyDirFromContainer $ADMIN__SERVICE "dist"
  # SITE
  funCopyDirFromContainer $SITE__SERVICE ".output"
  docker compose -f docker-build.yml --env-file ./.env-${env} stop
}

# run containers
function funRunContainers {
  docker compose --env-file ./.env-${ENV_RUN} ${mode}
}

####################################################################

# Init
if [ $mode == "init" ]; then
    funInit
fi

# Build
if [ $mode == "build" ]; then
    funBuild
fi

# Recreate containers to pass "build files"
if [ $mode == "start" ]; then
  docker compose -f docker-compose.yml --env-file ./.env-${env} create
fi

# Run containers: up / start / stop
if [ $mode == "up" ] || [ $mode == "start" ] || [ $mode == "stop" ]; then
  funRunContainers
fi

# Run a script that creates a database backup 
if [ $mode == "start" ]; then
  # docker exec -it newcatalog__service--db-main node server.js
  docker exec -it ${PROJECT_NAME}__${DB_MAIN__SERVICE} node server.js
fi