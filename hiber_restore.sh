#!/vendor/bin/sh

# Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause-Clear

# Post Restore


if [ "$(cat /sys/class/remoteproc/remoteproc0/state)" != "running" ]; then
    echo start > /sys/class/remoteproc/remoteproc0/state
fi

if [ "$(cat /sys/class/remoteproc/remoteproc1/state)" != "running" ]; then
    echo start > /sys/class/remoteproc/remoteproc1/state
fi

if [ "$(cat /sys/class/remoteproc/remoteproc2/state)" != "running" ]; then
    echo start > /sys/class/remoteproc/remoteproc2/state
fi

swapoff /dev/block/sda13
