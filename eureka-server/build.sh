#!/usr/bin/env bash
docker rmi eureka:v1
docker build -t eureka:v1 .