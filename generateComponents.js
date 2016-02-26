var fs = require('fs');
var currentVersion = "V 0.5.3";

function findModuleFiles(_name) {
  var totalList = fs.readdirSync("src/modules").map(function (file) {
    return "../../modules/" + file
  }).concat(fs.readdirSync("src/layout").map(function (file) {
    return "../../layout/" + file
  })).concat(fs.readdirSync("src/states").map(function (file) {
    return "../../states/" + file
  }));

  var fileList = [];
  for (index in totalList) {
    var file = totalList[index];
    if("_" + file.split("_")[1] == _name){
      fileList.push(file);
    }
  }
  return fileList
}

function findDependency() {
  var mixinsList = fs.readdirSync("src/mixins").map(function (file) {
    return "../../mixins/" + file
  });
  var variablesList = fs.readdirSync("src/variables").map(function (file) {
    return "../../variables/" + file
  });
  var totalList = variablesList.concat(mixinsList);

  return totalList
}

function outputFile(_list, _path){
  var _nameList = _list.map(function (file) {
    return '@import "' + file + '"'
  });
  var _str = "/* smaless: " + currentVersion + " */\n" + _nameList.join(';\n');
  fs.writeFile(_path, _str, function (err) {
    if(err){console.log("write file" + _path + "error: " + err)}
  });
}

(function main(argument) {
  var totalList = fs.readdirSync("src/layout").concat(fs.readdirSync("src/modules")).concat(fs.readdirSync("src/states"));
  for(index in totalList){
    var file = totalList[index];
    var nameList = findDependency().concat(findModuleFiles(file));
    outputFile(nameList, "src/tmp/components/" + file);
  }
  var baseList = findDependency().concat(["../../_base.scss"]);
  outputFile(baseList, "src/tmp/components/_base.scss");
}).call(this);
