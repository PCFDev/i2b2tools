#!/bin/bash

# Remove temporary files created by install process (but leave installation intact)

echo "[i2b2/post-install.sh] Removing compiled Java classes"
find .. -name *.class | xargs rm

echo "[i2b2/post-install.sh] Removing interpolated files"
find -name *.interpolated | xargs rm

echo "[i2b2/post-install.sh] Removing Shrine.sql"
rm Shrine.sql

echo "[i2b2/post-install.sh] Removing backup directory"
rm -rf backup/
