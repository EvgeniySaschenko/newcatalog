env=$1
mode=$2

source ./.env-$env

# delete local node_modules
function funDeleteNodeModules {
  local path_node_modules="./$1/node_modules"
  if [ -d $path_node_modules ]; then
    local result=$(rm -rf -R $path_node_modules) && local isDelete=true
    echo "$result"
    if [ "$isDelete" != true ]; then
      exit
    fi
    echo '--> Delete node_modules' "$1" 'local'
  fi
}

# copy to local node_modules
function funCopyNodeModules {
  local result=$(docker cp -a "${PROJECT_NAME}__$1:${WORKDIR_BASE}/$1/node_modules" "./$1") && local isCopy=true
  echo "$result"
  if [ "$isCopy" != true ]; then
    exit
  fi
  echo '--> Copy node_modules' "$1" 'local'
}

# Init
function funInit {
  echo '--> Init - start'

  # 1. Containers are created to receive node_modules

  local result1=$(docker compose -f docker-node-modules.yml --env-file ./.env-${env} up) && local isBuild1=true
  echo "$result1"
  if [ "$isBuild1" != true ]; then
    exit
  fi

  # 2. node_modules are copied from the docker to the local computer, this is necessary for "EsLint", TypeScript, etc. to work.

  # ADMIN
  funDeleteNodeModules $ADMIN__SERVICE
  funCopyNodeModules $ADMIN__SERVICE

  # API
  funDeleteNodeModules $API__SERVICE
  funCopyNodeModules $API__SERVICE

  # SITE
  funDeleteNodeModules $SITE__SERVICE
  funCopyNodeModules $SITE__SERVICE

  docker compose -f docker-node-modules.yml --env-file ./.env-${env} stop

  # 3. Other containers are created.

  local result2=$(docker compose --env-file ./.env-${env} up) && local isBuild2=true
  echo "$result2"
  if [ "$isBuild2" != true ]; then
    exit
  fi
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

# Run containers: up / start / stop
if [ $mode == "up" ] || [ $mode == "start" ] || [ $mode == "stop" ]; then
   funRunContainers
fi

# Run a script that creates a database backup 
if [ $mode == "start" ]; then
  # docker exec -it newcatalog__service--db-main node server.js
  docker exec -it ${PROJECT_NAME}__${DB_MAIN__SERVICE} node server.js
fi