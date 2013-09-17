compile abstract instructions
scanForCleanBlocks
	"Answer the number of clean blocks found in the literal frame"
	| numCleanBlocks |
	numCleanBlocks := 0.
	1 to: (coInterpreter literalCountOf: methodObj) do:
		[:i| | lit |
		lit := coInterpreter fetchPointer: i ofObject: methodObj.
		(coInterpreter startPCOrNilOfLiteral: lit in: methodObj) ifNotNil:
			[:startPCOrNil| numCleanBlocks := numCleanBlocks + 1]].
	^numCleanBlocks