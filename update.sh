#!/bin/sh -xe

MASHA1=`git rev-parse MA/maint/3.2.3`
if git log -l1 | grep -q "$MASHA1"; then
  exit 0
fi

for dir in Modelica ModelicaReference ModelicaServices ModelicaTest ModelicaTestOverdetermined.mo ObsoleteModelica3.mo Complex.mo; do
  rm -rf "$dir"
  git checkout MA/maint/3.2.3 "$dir"
  git add "$dir"
done
rm -rf Modelica/Resources/Library
patch --ignore-whitespace -p1 -f < Modelica.patch
patch --ignore-whitespace -p1 -f < ModelicaServices.patch
docker run -w "$PWD" -v "$PWD:$PWD" openmodelica/openmodelica:v1.14.1-minimal omc patch.mos
git config --global user.email "openmodelica@ida.liu.se"
git config --global user.name "OpenModelica Jenkins"
git commit -a -m "Update to $MASHA1"
git push github OM/maint/3.2.3
