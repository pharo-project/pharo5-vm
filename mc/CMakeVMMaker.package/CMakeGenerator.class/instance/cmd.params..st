cmake commands
cmd: cmdName params: aString

	output nextPutAll: cmdName;
		nextPut: $(;
		nextPutAll: aString;
		nextPut: $);
		cr
