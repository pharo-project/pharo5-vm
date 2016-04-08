compile abstract instructions
compileEntireFullBlockMethod: numCopied
	regArgsHaveBeenPushed := false.
	^super compileEntireFullBlockMethod: numCopied