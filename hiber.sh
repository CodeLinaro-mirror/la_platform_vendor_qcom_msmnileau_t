#!/vendor/bin/sh

# Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above
#       copyright notice, this list of conditions and the following
#       disclaimer in the documentation and/or other materials provided
#       with the distribution.
#     * Neither the name of The Linux Foundation nor the names of its
#       contributors may be used to endorse or promote products derived
#       from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
# ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# Changes from Qualcomm Innovation Center are provided under the following license:
#
# Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause-Clear

VERSION=1.0
echo "Current hibernation script version is $VERSION"

sda=`ls -l /dev/block/by-name/swap_a | awk '{print $NF}' | awk -F'[/]' '{print $4}'`
major=`ls -l /dev/block/${sda} | awk '{print $5}' | grep -o '[0-9]*'`
minor=`ls -l /dev/block/${sda} | awk '{print $6}' | grep -o '[0-9]*'`
echo "${major}:${minor}" > /sys/power/resume
sleep 3

echo "enable swap partition"
mkswap /dev/block/sda13
swapon /dev/block/sda13 -p 0

echo 100 > /proc/sys/vm/swappiness
echo 0 > /sys/power/image_size
echo "UI turn off"
cat /proc/swaps

sync

while [ "$(cat /sys/class/remoteproc/remoteproc0/state)" != "offline" ]; do
    echo "stop" > /sys/class/remoteproc/remoteproc0/state
        sleep 1
done

while [ "$(cat /sys/class/remoteproc/remoteproc1/state)" != "offline" ]; do
    echo "stop" > /sys/class/remoteproc/remoteproc1/state
        sleep 1
done

while [ "$(cat /sys/class/remoteproc/remoteproc2/state)" != "offline" ]; do
    echo "stop" > /sys/class/remoteproc/remoteproc2/state
        sleep 1
done

echo shutdown > /sys/power/disk

#drop cache
while true
do
  echo 3 > /proc/sys/vm/drop_caches
  sync
done
