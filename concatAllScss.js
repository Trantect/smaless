var fs = require('fs');
var currentVersion = "0.5.0";

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
  .concat(fs.readdirSync("src/layout").map(function (file) {
    return "../layout/" + file
  }))
  .concat(fs.readdirSync("src/modules").map(function (file) {
    return "../modules/" + file
  }))
  .concat(fs.readdirSync("src/states").map(function (file) {
    return "../states/" + file
  }))
  totalList.push("../_base.scss");
  writeName(totalList);
}).call(this);
