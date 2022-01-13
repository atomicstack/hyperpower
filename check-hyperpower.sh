#!/bin/bash

hyperpower_install_path=/mnt/$USER/AppData/Roaming/Hyper/.hyper_plugins/node_modules/hyperpower/index.js
hyperpower_my_path=/home/$USER/git_tree/hyperpower/index.js
hyperpower_base_hash=f71816ef34b7b37f2ea46ecfc3ff09ea81403c239ca1bc82392abedb75e4e949
hyperpower_installed_hash=$(sha256sum $hyperpower_install_path | awk '{print $1}')
# hyperpower_patched_hash=0a9ef64da9a42fab250393f4382a25fb4a9f325baf4ef3a5df6d7d02d11a50a2
hyperpower_patched_hash=$(sha256sum "$hyperpower_my_path" | awk '{print $1}')

if [[ $hyperpower_installed_hash == $hyperpower_base_hash ]]; then
  # echo "\$hyperpower_installed == \$hyperpower_base, please run this:"
  cp -v $hyperpower_my_path $hyperpower_install_path
  echo "hyperpower/index.js replaced with unfucked-wow-mode variant" 1>&2
elif [[ $hyperpower_installed_hash == $hyperpower_patched_hash ]]; then
  # echo "all good!"
  true
else
  echo "weird hash for $hyperpower_install_path: $hyperpower_installed_hash" 1>&2
  echo -ne "to flatten the installed version, run this:\n\t"
  echo "cp -v $hyperpower_my_path $hyperpower_install_path" 1>&2
fi
