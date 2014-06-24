debug support
fullGC
	"self halt."
	coInterpreter transcript
		cr; nextPutAll:'<Running full GC ('; print: coInterpreter byteCount; space; print: freeStart; nextPutAll: ')...'; flush.
	super fullGC.
	coInterpreter transcript show: ' done>'