debugging
reportLastNInstructions
	<doNotGenerate>
	lastNInstructions do:
		[:thing|
		thing isArray
			ifTrue:
				[thing first isString "i.e. { '(simulated return to '. processor retpcIn: coInterpreter memory. ')'}"
					ifTrue:
						[thing do:
							[:stringOrNumber|
							coInterpreter transcript nextPutAll: (stringOrNumber isString
													ifTrue: [stringOrNumber]
													ifFalse: [stringOrNumber hex])].
							coInterpreter transcript cr]
					ifFalse:
						[coInterpreter transcript cr.
						 (self relativeLabelForPC: (thing at: processor registerStatePCIndex)) ifNotNil:
							[:label| coInterpreter transcript nextPutAll: label; nextPut: $:; cr].
						 processor printRegisterState: thing on: coInterpreter transcript]]
			ifFalse:
				[coInterpreter transcript
					nextPutAll: (EagerInstructionDecoration
									ifTrue: [thing]
									ifFalse: [processor
												decorateDisassembly: thing
												for: self]); cr]].
	coInterpreter transcript flush