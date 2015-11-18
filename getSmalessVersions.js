var bower = require('bower');
var fs = require('fs');

bower.commands
.info("smaless")
.on('end', function(_info) {
  fs.writeFile('smaless/versionList.txt', _info.versions.join(" "), function (err) {
  	if (err){
  		console.log(err);
  	}
   });
});
