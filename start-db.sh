#!/bin/bash

podman stop dart_app_db
podman volume create pg_data
podman run -d --rm -p 5432:5432 -v pg_data:/var/lib/postgresql/data -e POSTGRES_USER=app -e POSTGRES_PASSWORD=password --name dart_app_db postgres:alpine

