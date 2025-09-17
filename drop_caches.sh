#!/vendor/bin/sh

# Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause-Clear

while :
do
  echo 3 > /proc/sys/vm/drop_caches
  sleep 1
  # We can press Ctrl + C to exit the script
done
