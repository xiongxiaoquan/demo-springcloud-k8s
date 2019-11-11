#!/usr/bin/env bash
docker rmi service-provider:v1
docker build -t service-provider:v1 .