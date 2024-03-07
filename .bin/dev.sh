#!/bin/bash
reset

# Copy .env.example to .env in any folder that
# .env.example exists and .env does not exists
folder_current=$(pwd)
for folder in "$folder_current"/*; do
    if [[ "$folder" =~ ^\..* ]]; then
        continue
    fi

    if [ -f "$folder/.env.example" ]; then
        if [ ! -f "$folder/.env" ]; then
            cp "$folder/.env.example" "$folder/.env"
        fi
    fi
done

# Create Docker Compose command based on selected options

database_options=("mysql" "postgres" "mongodb")
database_value="mysql"

backend_options=("laravel" "hyperf" "nest")
backend_value="laravel"

frontend_options=("nuxt")
frontend_value="nuxt"

docker_compose_cmd="docker-compose up --build --force-recreate --remove-orphans"

PS3="Choose database: "
select database_value in "${database_options[@]}"; do
    docker_compose_cmd="$docker_compose_cmd --scale $database_value=1"
    break
done

PS3="Choose backend: "
select backend_value in "${backend_options[@]}"; do
    docker_compose_cmd="$docker_compose_cmd --scale $backend_value=1"
    break
done

PS3="Choose frontend: "
select frontend_value in "${frontend_options[@]}"; do
    docker_compose_cmd="$docker_compose_cmd --scale $frontend_value=1"
    break
done

tput setaf 2
echo $docker_compose_cmd
tput sgr0

eval $docker_compose_cmd
