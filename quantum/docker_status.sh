#!/bin/bash

Docker_Running_Container=$(docker ps --all --format "table {{.Names}} {{.Status}} " -f status=running)

Docker_Exited_Container=$(docker ps --all --format "table {{.Names}} {{.Status}} " -f status=exited)

Docker_Dead_Container=$(docker ps --all --format "table {{.Names}} {{.Status}} " -f status=dead)

Docker_Created_Container=$(docker ps --all --format "table {{.Names}} {{.Status}} " -f status=created)



Docker_Running_Container_Text_Send=$(echo -e "$(date) \nDocker Running Container \
            \n \
            $(expr $(docker ps --all --format "table {{.Names}} {{.Status}} " -f status=running | wc -l) - 1) \
            \n \
            \n${Docker_Running_Container}")

Docker_Exited_Container_Text_Send=$(echo -e "$(date) \nDocker Exited Container \
            \n \
            $(expr $(docker ps --all --format "table {{.Names}} {{.Status}} " -f status=exited | wc -l) - 1) \
            \n \
            \n${Docker_Exited_Container}")

Docker_Dead_Container_Text_Send=$(echo -e "$(date) \nDocker Dead Container \
            \n \
            $(expr $(docker ps --all --format "table {{.Names}} {{.Status}} " -f status=dead | wc -l) - 1) \
            \n \
            \n${Docker_Dead_Container}")

Docker_Created_Container_Text_Send=$(echo -e "$(date) \nDocker Created Container \
            \n \
            $(expr $(docker ps --all --format "table {{.Names}} {{.Status}} " -f status=created | wc -l) - 1) \
            \n \
            \n${Docker_Created_Container}")


