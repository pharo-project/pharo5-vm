target directories
interpreterFilename
	"what is the filename for the core interpreter. Default is interp.c"
	^super interpreterFilename copyWithoutAll: '.c'