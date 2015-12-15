for file in ./src/tmp/components/* ; do
  name=`echo $file | cut -d '_' -f2`
  scssName="_$name"
  cssName="`echo $name | cut -d '.' -f1`.css"
  sass src/tmp/components/$scssName build/components/$cssName
done
