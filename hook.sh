#!/usr/bin/env bash
set -e

# Called after a git push

echo "------------------------------------------------"
echo #
echo "Global assets web service hook script started"
echo #

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$THIS_DIR"
# When global assets change, they will be built when building any service where they are used
# All services where they are used are built using the deploy.sh script
./deploy.sh

echo "Global assets web service hook script finished"
echo "------------------------------------------------"
exit 0
