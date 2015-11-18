cd smaless
versions=`cat versionList.txt`
for i in $versions
do
  rm -rf $i
  mkdir $i
  rm -rf bower_components
  ../node_modules/bower/bin/bower install smaless#$i
  mv bower_components/smaless/* $i
  rm -rf bower_components
done
cd ..
