env=$1
mode=$2

source ./.env-$env

#build containers
function funBuildContainers {
  echo '--> Build containers - start'
  local result=$(docker compose --env-file ./.env-${env} build) && local isBuild=true
  echo "$result"
  if [ "$isBuild" != true ]; then
    exit
  fi
  echo '--> Build containers - end'
}

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

# run containers
function funRunContainers {
  docker compose --env-file ./.env-${ENV_RUN} ${mode}
}

####################################################################

# Build containers
if [ $mode == "build" ]; then
    funBuildContainers
fi

# Copy node_modules what would work "EsLint", TypeScript, etc.
if [ $mode == "node-modules" ]; then
    docker compose -f docker-node-modules.yml  --env-file ./.env-${ENV_RUN} start

    # ADMIN
    funDeleteNodeModules $ADMIN__SERVICE
    funCopyNodeModules $ADMIN__SERVICE

    # API
    funDeleteNodeModules $API__SERVICE
    funCopyNodeModules $API__SERVICE

    # SITE
    funDeleteNodeModules $SITE__SERVICE
    funCopyNodeModules $SITE__SERVICE

    docker compose -f docker-node-modules.yml  --env-file ./.env-${ENV_RUN} stop
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