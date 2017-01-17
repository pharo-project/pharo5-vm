debugging traps
normalSend
	"Catch errors before we start the whole morphic error process"

	"(byteCount > 4000000 and: [(self stringOf: messageSelector) = 'sorts:before:'])
		ifTrue: [self halt]."
	^ super normalSend