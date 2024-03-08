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

docker-compose up --build --force-recreate --remove-orphans


# # Create Docker Compose command based on selected options
# docker_compose_cmd="docker-compose up --build --force-recreate --remove-orphans"

# PS3="Choose database: "
# choose_items=("mysql" "postgres" "mongodb")
# choose_value="mysql"

# select choose_value in "${choose_items[@]}"; do
#     for value in "${choose_items[@]}"; do
#         if [[ $value == $choose_value ]]; then
#             docker_compose_cmd="$docker_compose_cmd --scale $value=1"
#         else
#             docker_compose_cmd="$docker_compose_cmd --scale $value=0"
#         fi
#     done
#     break
# done


# PS3="Choose backend: "
# choose_items=("laravel" "hyperf" "nest")
# choose_value="laravel"

# select choose_value in "${choose_items[@]}"; do
#     for value in "${choose_items[@]}"; do
#         if [[ $value == $choose_value ]]; then
#             docker_compose_cmd="$docker_compose_cmd $value=1"
#         else
#             docker_compose_cmd="$docker_compose_cmd $value=0"
#         fi
#     done
#     break
# done


# PS3="Choose frontend: "
# choose_items=("nuxt")
# choose_value="nuxt"

# select choose_value in "${choose_items[@]}"; do
#     for value in "${choose_items[@]}"; do
#         if [[ $value == $choose_value ]]; then
#             docker_compose_cmd="$docker_compose_cmd $value=1"
#         else
#             docker_compose_cmd="$docker_compose_cmd $value=0"
#         fi
#     done
#     break
# done


# tput setaf 2
# echo $docker_compose_cmd
# tput sgr0

# eval $docker_compose_cmd
