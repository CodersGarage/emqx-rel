#!/bin/sh

export AUTH_URL="http://localhost:8282"

make
cd _rel/emqx && ./bin/emqx console
