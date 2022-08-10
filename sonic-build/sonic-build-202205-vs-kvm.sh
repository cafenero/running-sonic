#!/bin/bash -xe

# pre-install
sudo apt install -y python3-pip
sudo pip3 install j2cli

# Ensure the 'overlay' module is loaded on your development system
sudo modprobe overlay

# Enter the source directory
git clone https://github.com/Azure/sonic-buildimage.git
cp ./config.user sonic-buildimage/rules/
cd sonic-buildimage

# (Optional) Checkout a specific branch. By default, it uses master branch. For example, to checkout the branch 201911, use "git checkout 201911"

# Check this list !!!
# https://sonic-build.azurewebsites.net/ui/sonic/pipelines/142/builds?branchName=master
# https://sonic-build.azurewebsites.net/ui/sonic/pipelines/142/builds?branchName=202205
#
# BuildId	BuildNumber	BranchName	BuildName	Result	StartTime	FinishTime	Commit	BuildLink	Artifact
# 133812	20220811.4	202205	Azure.sonic-buildimage.official.vs	succeeded	2022-08-11T08:28:57	2022-08-11T16:32:29	e8fe21b3a4	Build Link	Artifacts
git checkout e8fe21b3a4

# Execute make init once after cloning the repo, or after fetching remote repo with submodule updates
make init

# Execute make configure once to configure ASIC
make configure PLATFORM=vs

# Build SONiC image with 4 jobs in parallel.
# Note: You can set this higher, but 4 is a good number for most cases
# and is well-tested.
# make SONIC_BUILD_JOBS=4 all
# make SONIC_BUILD_JOBS=4 target/sonic-vs.bin
make SONIC_BUILD_JOBS=4 target/sonic-vs.img.gz
