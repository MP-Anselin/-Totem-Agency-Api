#!/bin/bash

#rm -f /rubyapp/tmp/pids/server.pid 2> /dev/null

yarn install --check-files

rm -f /rubyapp/tmp/pids/server.pid
rails server -b 0.0.0.0