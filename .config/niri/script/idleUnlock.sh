#!/usr/bin/env bash

dms kill
mkdir ~/dms_logs
DMS_VERBOSE_LOGS=1 nohup dms run > ~/dms_logs/dms-$(date +%s).txt 2>&1 &
