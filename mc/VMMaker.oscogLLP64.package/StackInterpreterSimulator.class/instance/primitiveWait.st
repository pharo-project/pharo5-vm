debugging traps
primitiveWait
	"Catch errors before we start the whole morphic error process"

	"byteCount > 1000000 ifTrue: [self halt]."  "Ignore early process activity"
	^ super primitiveWait