#!/bin/bash

Docker_Running_Container=$(docker ps --all --format "table {{.Names}} {{.Status}} " -f status=running)

Docker_Exited_Container=$(docker ps --all --format "table {{.Names}} {{.Status}} " -f status=exited)

Docker_Dead_Container=$(docker ps --all --format "table {{.Names}} {{.Status}} " -f status=dead)

Docker_Created_Container=$(docker ps --all --format "table {{.Names}} {{.Status}} " -f status=created)