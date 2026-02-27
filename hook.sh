#!/usr/bin/env bash

# Called after a git push

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$THIS_DIR"
# When global assets change, they will be built when building any service where they are used
# All services where they are used are built using the deploy.sh script
# No need to waste CPU cycles building them without ever using them
./deploy.sh
