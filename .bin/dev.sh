#!/bin/bash
reset

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
  break
done

tput setaf 2
echo $docker_compose_cmd
eval $docker_compose_cmd
tput sgr0
