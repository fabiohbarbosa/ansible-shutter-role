#!/bin/bash
pwd=`pwd`
volume="${pwd}:/tmp/environment-setup"
image_name="ansible-shutter-role"

cd tests
for dir in */ ; do
  for subdir in "$dir*" ; do
    IFS=' ' list=(${subdir})
    for distro in "${list[@]}"; do
      echo "Starting build ${distro}"

      version_file=${distro}/version

      if ! [[ -f "${version_file}" ]]; then
        echo "${version_file} not found."
        exit 1
      fi

      cp Dockerfile.base ${distro}/Dockerfile
      cp -a test-distro.sh ${distro}/

      docker_image=`cat ${version_file}`
      sed -i "s/_image_/${docker_image}/g" ${distro}/Dockerfile

      docker build -t ${image_name} ${distro} && docker run -v ${volume} --rm -i -t ${image_name}

      if [[ $? != 0 ]]; then
        echo
        echo "==="
        echo "[ERROR] Error to build ${distro}!"
        exit 1
      fi
      echo '##############################################################################'
    done
  done
done
