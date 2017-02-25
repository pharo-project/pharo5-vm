debugging
reportLastNInstructions
	<doNotGenerate>
	| skipNext printInst |
	skipNext := false.
	printInst := [:inst|
				coInterpreter transcript nextPutAll:
					(EagerInstructionDecoration
						ifTrue: [inst]
						ifFalse: [processor
									decorateDisassembly: inst
									for: self
									fromAddress: ((inst at: 3) = $r
													ifTrue: [Integer readFrom: inst readStream]
													ifFalse: [Integer readFrom: inst readStream base: 16])]); cr].
	lastNInstructions withIndexDo:
		[:thing :idx| | next pc label |
		skipNext
			ifTrue: [skipNext := false]
			ifFalse:
				[thing isArray
					ifTrue:
						[thing first isString "i.e. { '(simulated return to '. processor retpcIn: coInterpreter memory. ')'}"
							ifTrue:
								[thing do:
									[:stringOrNumber|
									coInterpreter transcript nextPutAll: (stringOrNumber isString
															ifTrue: [stringOrNumber]
															ifFalse: [stringOrNumber hex])].
									coInterpreter transcript cr]
							ifFalse: "if possible, add the label to the instruction line to condense the output"
								[coInterpreter transcript cr.
								 pc := thing at: processor registerStatePCIndex.
								 label := self relativeLabelForPC: pc.
								 ((next := lastNInstructions at: idx + 1 ifAbsent: []) notNil
								  and: [next isString
								  and: [(Integer readFrom: next readStream radix: 16) = pc]])
									ifTrue: "Decorate instruction and eliminate pc line"
										[skipNext := true.
										 processor printRegisterStateExceptPC: thing on: coInterpreter transcript.
										 label ifNotNil: [coInterpreter transcript nextPutAll: label; space].
										 printInst value: next]
									ifFalse:
										[label ifNotNil: [coInterpreter transcript nextPutAll: label; nextPut: $:; cr].
										 processor printRegisterState: thing on: coInterpreter transcript]]]
					ifFalse:
						[printInst value: thing]]].
	coInterpreter transcript flush