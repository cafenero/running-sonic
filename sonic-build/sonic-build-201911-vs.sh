#!/bin/bash -xe

# pre-install
sudo apt install -y python3-pip
sudo pip3 install j2cli

# Ensure the 'overlay' module is loaded on your development system
sudo modprobe overlay

# Enter the source directory
git clone https://github.com/Azure/sonic-buildimage.git
cd sonic-buildimage

# (Optional) Checkout a specific branch. By default, it uses master branch. For example, to checkout the branch 201911, use "git checkout 201911"
git checkout 201911

# Execute make init once after cloning the repo, or after fetching remote repo with submodule updates
make init

# Execute make configure once to configure ASIC
make configure PLATFORM=vs

# Build SONiC image with 4 jobs in parallel.
# Note: You can set this higher, but 4 is a good number for most cases
# and is well-tested.
# make SONIC_BUILD_JOBS=4 all
make SONIC_BUILD_JOBS=4 target/sonic-vs.bin
