var fs = require('fs');
var nameList = [];
var path = require("path");

fs.readdir("src/", function (err, files) {
    if (err) {
        throw err;
    }

    var scssPath = files.map(function (file) {
        return path.join("src/", file);
    }).filter(function (file) {
        return fs.statSync(file).isDirectory();
    })

    scssPath.unshift("src/.");
    scssPath.splice(scssPath.indexOf("src/mixins"), 1)
    scssPath.unshift("src/mixins");
    scssPath.splice(scssPath.indexOf("src/variables"), 1)
    scssPath.unshift("src/variables");

    scssPath.forEach(function (dir) {
      fs.readdir(dir + "", function (err, files) {
        for (_index in files){
          var file = files[_index];
          if(file.split(".")[1] == "scss"){
            nameList.push(dir.split("src/")[1] + "/" +file);
          }
        }
        writeName(nameList);
      });
    });
});

function writeName(_list){
  var _nameList = [];
  for(_index in _list){
    _nameList.push('@import "' + _list[_index] + '"')
  }
  var _str = _nameList.join(';\n');
  fs.writeFile('src/main.scss', _str, function (err) {
  	if (err){
  		console.log(err);
  	}
   });
}
