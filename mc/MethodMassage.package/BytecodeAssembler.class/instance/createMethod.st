assembly
createMethod
	| header size |
	header := encoder
					computeMethodHeaderForNumArgs: code numArgs
					numTemps: code numTemps
					numLits: encoder allLiterals size
					primitive: code primitive.
	
	code flag ifTrue: "kind of crappy that there's no setter..."
		[header := header bitOr: (1 << 29)].
	size := sizes size = 0 ifTrue: [0] ifFalse: [self totalSizeFrom: 1 to: sizes size].
	method := code trailer
					createMethod: size
					class: code compiledMethodClass
					header: header.
	method needsFrameSize: code frameSize - method numTemps