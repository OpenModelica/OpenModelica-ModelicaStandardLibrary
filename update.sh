#!/bin/sh -xe

MASHA1=`git rev-parse MA/maint/4.1.x`
if git log -n1 | grep -q "$MASHA1"; then
  exit 0
fi

for dir in Modelica ModelicaReference ModelicaServices ModelicaTest ModelicaTestConversion4.mo ModelicaTestOverdetermined.mo ObsoleteModelica4.mo Complex.mo; do
  rm -rf "$dir"
  git checkout MA/maint/4.1.x "$dir"
  git add "$dir"
done
rm -rf Modelica/Resources/Library
patch --ignore-whitespace -p1 -f < ModelicaServices.patch
docker run -w "$PWD" -v "$PWD:$PWD" openmodelica/openmodelica:v1.14.1-minimal omc patch.mos
git config --global user.email "openmodelica@ida.liu.se"
git config --global user.name "OpenModelica Jenkins"
git commit -a --allow-empty -m "Update to $MASHA1"
git push github OM/maint/4.1.x
