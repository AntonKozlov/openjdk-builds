#!/bin/sh

BUNDLENAME=$1
CRIU_RELEASE=release-crac

id=$(curl https://api.github.com/repos/crac/criu/releases/tags/$CRIU_RELEASE | jq .assets[0].id)
curl https://api.github.com/repos/crac/criu/releases/assets/$id -LJOH 'Accept: application/octet-stream'
CRIU_BUNDLE=criu-crac-$CRIU_RELEASE

tar axf $CRIU_BUNDLE.tar.gz

mv build/linux-x86_64-server-release/images/jdk $BUNDLENAME
mv build/linux-x86_64-server-release/images/docs $BUNDLENAME-docs

cp $CRIU_BUNDLE/sbin/criu $BUNDLENAME/lib/criu
sudo chown root:root $BUNDLENAME/lib/criu
sudo chmod u+s $BUNDLENAME/lib/criu

tar -zcf $BUNDLENAME.tar.gz $BUNDLENAME
tar -zcf $BUNDLENAME-docs.tar.gz $BUNDLENAME-docs
