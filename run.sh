env=$1
mode=$2

source ./.env-$env

env_files="--env-file ${APP_ENV_FILE} --env-file ${APP_ENV_SECRET_FILE} --env-file ${APP_ENV_CUSTOM_FILE}"

# Generate a random string and write it to the .env file
function generateRandomString() {
  local length=${1:-32}
  local chars=${2:-'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'}
  local str=''
  for ((i = 0; i < length; ++i)); do
      str+=${chars:RANDOM%${#chars}:1}
  done
  echo "$str"
}

# Create file env secret
function createFileEnvSecret() {
  local random_number=$((RANDOM % 16 + 1))
  echo "APP_SECRET_KEY='$(generateRandomString 32)$(generateRandomString $random_number)'" > $APP_ENV_SECRET_FILE
}

###########################################################################

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
  local result=$(docker cp -a "${APP_NAME}__$1:${APP_DIR}/$2" "./$1") && local isCopy=true
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
  docker compose -f docker-node-modules.yml ${env_files} create

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

  # BACKUP
  funDeleteDirLocal $BACKUP__SERVICE "node_modules"
  funCopyDirFromContainer $BACKUP__SERVICE "node_modules"

  # 3. Other containers are created.
  if [ $env == "prod" ]; then
    docker compose -f docker-compose.yml ${env_files}create
    docker compose -f docker-compose.yml ${env_files} start
  fi

  if [ $env == "dev" ]; then
    docker compose -f docker-compose.yml ${env_files} up
  fi
}

# Build
function funBuild {
  echo '--> Build - start'
  funDeleteDirLocal $ADMIN__SERVICE "dist"
  funDeleteDirLocal $SITE__SERVICE ".output"

  docker compose -f docker-build.yml ${env_files} up
  # ADMIN
  funCopyDirFromContainer $ADMIN__SERVICE "dist"
  # SITE
  funCopyDirFromContainer $SITE__SERVICE ".output"
  docker compose -f docker-build.yml ${env_files} stop
}

# run containers
function funRunContainers {
  docker compose ${env_files} ${mode}
}

####################################################################

# To authorize containers via HTTP requests, a random secret key is generated in the Docker internal network. 
# The key file is stored in the tmp folder because the key must be available when the container restarts and must not be copied to the repository.
if [ ! -f "$APP_ENV_SECRET_FILE" ]; then
  generateRandomString
  createFileEnvSecret
fi

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
  docker compose -f docker-compose.yml ${env_files} create
fi

# Run containers: up / start / stop
if [ $mode == "up" ] || [ $mode == "start" ] || [ $mode == "stop" ]; then
  funRunContainers
fi