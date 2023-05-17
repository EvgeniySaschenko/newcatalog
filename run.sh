env=$1
mode=$2

source ./.env-$env

# delete local dir
# $1 - sevice dir
# $2 - target dir
function funDeleteRir {
  local path_dir="./$1/$2"
  if [ -d $path_dir ]; then
    local result=$(rm -rf -R $path_dir) && local isDelete=true
    echo "$result"
    if [ "$isDelete" != true ]; then
      exit
    fi
    echo '--> Delete service:' "$1", dir: "$2" - 'local'
  fi
}

# copy to local dir
# $1 - sevice dir
# $2 - target dir
function funCopyDir {
  local result=$(docker cp -a "${PROJECT_NAME}__$1:${WORKDIR_BASE}/$1/$2" "./$1") && local isCopy=true
  echo "$result"
  if [ "$isCopy" != true ]; then
    exit
  fi
  echo '--> Copy service:' "$1",  dir: "$2" - 'local'
}

# Init
function funInit {
  echo '--> Init - start'

  # 1. Containers are created to receive node_modules

  local result1=$(docker compose -f docker-node-modules.yml --env-file ./.env-${env} up) && local isBuild1=true
  echo "$result1"
  if [ "$isBuild1" != true ]; then
    docker compose -f docker-node-modules.yml --env-file ./.env-${env} stop
    exit
  fi

  # 2. node_modules are copied from the docker to the local computer, this is necessary for "EsLint", TypeScript, etc. to work.

  # ADMIN
  funDeleteRir $ADMIN__SERVICE "node_modules"
  funCopyDir $ADMIN__SERVICE "node_modules"

  # API
  funDeleteRir $API__SERVICE "node_modules"
  funCopyDir $API__SERVICE "node_modules"

  # SITE
  funDeleteRir $SITE__SERVICE "node_modules"
  funCopyDir $SITE__SERVICE "node_modules"

  docker compose -f docker-node-modules.yml --env-file ./.env-${env} stop

  # 3. Other containers are created.

  local result2=$(docker compose --env-file ./.env-${env} up) && local isBuild2=true
  echo "$result2"
  if [ "$isBuild2" != true ]; then
    exit
  fi
}

# Build
function funBuild {
  echo '--> Build - start'
  docker compose -f docker-build.yml --env-file ./.env-${env} up

  # ADMIN
  funDeleteRir $ADMIN__SERVICE "dist"
  funCopyDir $ADMIN__SERVICE "dist"

  # SITE
  funDeleteRir $SITE__SERVICE ".output"
  funCopyDir $SITE__SERVICE ".output"

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

# Run containers: up / start / stop
if [ $mode == "up" ] || [ $mode == "start" ] || [ $mode == "stop" ]; then
   funRunContainers
fi

# Run a script that creates a database backup 
if [ $mode == "start" ]; then
  # docker exec -it newcatalog__service--db-main node server.js
  docker exec -it ${PROJECT_NAME}__${DB_MAIN__SERVICE} node server.js
fi