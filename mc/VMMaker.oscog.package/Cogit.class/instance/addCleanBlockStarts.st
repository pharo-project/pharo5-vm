compile abstract instructions
addCleanBlockStarts
	1 to: (objectMemory literalCountOf: methodObj) do:
		[:i| | lit |
		lit := coInterpreter fetchPointer: i ofObject: methodObj.
		(coInterpreter startPCOrNilOfLiteral: lit in: methodObj) ifNotNil:
			[:startPCOrNil|
			 maxLitIndex := maxLitIndex max: i.
			 self addBlockStartAt: startPCOrNil - 1 "1-rel => 0-rel"
				numArgs: (coInterpreter argumentCountOfClosure: lit)
				numCopied: (coInterpreter copiedValueCountOfClosure: lit)
				span: (self spanForCleanBlockStartingAt: startPCOrNil - 1)]]