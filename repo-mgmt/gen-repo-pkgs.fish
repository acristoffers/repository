#!/usr/bin/env fish

mkdir -p fedora ubuntu

DIST_TAG=43 envsubst < repo.rpm.yml | nfpm pkg -f - --packager rpm --target fedora/
DIST_TAG=44 envsubst < repo.rpm.yml | nfpm pkg -f - --packager rpm --target fedora/

for codename in (grep Codename ../deb/conf/distributions | cut -d' ' -f2)
  CODENAME=$codename envsubst <esousa.sources.t >esousa.sources
  CODENAME=$codename envsubst < repo.deb.yml | nfpm pkg -f - --packager deb --target ubuntu/
end
rm esousa.sources
