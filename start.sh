#!/bin/bash

 

# check if iwlwifi kernel modules are installed

if lsmod | grep iwlwifi &> /dev/null ; then

  echo "iwlwifi kernel modules already installed"

else

    echo "installing iwlwifi kernel modules and firmware"

   

    # install AX200 firmware

    mount -o remount,rw /lib/firmware

    cp -a /usr/src/app/iwlwifi/firmware/* /lib/firmware

 

    # install iwlwifi kernel modules

    mount -o remount,rw /lib/modules

    if lsmod | grep cfg80211 &> /dev/null ; then

      modprobe -r cfg80211

    fi

    cp -a /usr/src/app/iwlwifi/modules/* /lib/modules/$(uname -r)/kernel

    depmod -a

    modprobe iwlwifi

fi
