env=$1
mode=$2

source ./.env-$env

#build containers
function funBuildContainers {
  local result=$(docker compose --env-file ./.env-${env} build) && local isBuild=true
  echo "$result"
  if [ "$isBuild" != true ]; then
    exit
  fi
  echo '--> Build containers'
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

# docker exec --detach -it newcatalog__service--db-main sh

# function funCreateDataBaseDump {
#   local container=${PROJECT_NAME}__${DB_MAIN__SERVICE}
#   local dirDocker=${WORKDIR_BASE}/${DB_MAIN__SERVICE}
#   local dirLocal=./${DB_MAIN__SERVICE}/tmp
#   docker exec  -it $container sh -c "${WORKDIR_BASE}/${DB_MAIN__SERVICE}/utils/create-dupm-db.sh"

#   mkdir -p $dirLocal
#   docker cp -a $container:$dirDocker/db-data259.sql $dirLocal/db-data259.sql
#   docker cp -a $container:$dirDocker/db-empty259.sql $dirLocal/db-empty259.sql
# }

####################################################################

# Build containers
if [ $mode == "build" ]; then
    funBuildContainers
fi

# Copy node_modules what would work "EsLint", TypeScript, etc.
if [ $mode == "node-modules" ]; then

    docker compose -f docker-compose.yml -f docker-node-modules.yml  --env-file ./.env-${ENV_RUN} start

    # ADMIN
    # funDeleteNodeModules $ADMIN__SERVICE
    # funCopyNodeModules $ADMIN__SERVICE

    # API
    funDeleteNodeModules $API__SERVICE
    # funCopyNodeModules $API__SERVICE

    # SITE
    # funDeleteNodeModules $API__SITE
    # funCopyNodeModules $API__SITE

    docker compose -f docker-compose.yml -f docker-node-modules.yml  --env-file ./.env-${ENV_RUN} stop
fi

# Run containers: up / start / stop
if [ $mode == "up" ] || [ $mode == "start" ] || [ $mode == "stop" ]; then
   funRunContainers
fi

# if [ $mode == "db-dump" ]; then
#    funCreateDataBaseDump
# fi
