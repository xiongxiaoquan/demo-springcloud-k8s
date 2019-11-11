#!/usr/bin/env bash
docker rmi service-consumer:v1
docker build -t service-consumer:v1 .