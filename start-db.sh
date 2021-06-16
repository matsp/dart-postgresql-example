#!/bin/bash

podman volume create pg_data
podman run -d --rm -p 5432:5432 -v pg_data:/var/lib/postgresql/data -v ./sql:/docker-entrypoint-initdb.d -e POSTGRES_USER=app -e POSTGRES_PASSWORD=password --name dart_app_db postgres:alpine
