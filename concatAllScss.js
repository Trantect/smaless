var fs = require('fs');
var currentVersion = "0.5.2";

function writeName(_list){
  var _nameList = _list.map(function (file) {
    return '@import "' + file + '"'
  })
  var _str = "/* smaless: " + currentVersion + " */\n" + _nameList.join(';\n');
  fs.writeFile('src/tmp/main.scss', _str, function (err) {
  	if (err){
  		console.log(err);
  	}
   });
}

(function main() {
  var totalList = fs.readdirSync("src/variables").map(function (file) {
    return "../variables/" + file
  })
  .concat(fs.readdirSync("src/mixins").map(function (file) {
    return "../mixins/" + file
  }))
  .concat(['../_base.scss'])
  .concat(fs.readdirSync("src/states").map(function (file) {
    return "../states/" + file
  }))
  .concat(fs.readdirSync("src/modules").map(function (file) {
    return "../modules/" + file
  }))
  .concat(fs.readdirSync("src/layout").map(function (file) {
    return "../layout/" + file
  }))
  writeName(totalList);
}).call(this);
