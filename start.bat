#!/bin/bash

cd $(dirname $0)
java -DSTOP.PORT=8887 -DSTOP.KEY=railo -jar -Xms256M  -Xmx512M lib/start.jar