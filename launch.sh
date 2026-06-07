#!/bin/bash

docker run -d \
--memory="128m" \
--cpus="0.5" \
--pids-limit=50 \
--cap-drop ALL \
-p 8080:8080 \
    dockerfile-security