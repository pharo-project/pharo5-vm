cmake commands
cmd: cmdName qparams: aString
	"quoted params"
	output nextPutAll: cmdName;
		nextPutAll: '("';
		nextPutAll: aString;
		nextPutAll: '")';
		cr
