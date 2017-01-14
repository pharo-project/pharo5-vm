bytecode generators
genInlinedIdenticalOrNotIf: orNot
	"Decompose code generation for #== into a common constant-folding version,
	 followed by a double dispatch throguh the objectRepresentation to a version
	 that doesn't deal with forwarders and a version that does."
	| primDescriptor result |
	<var: #primDescriptor type: #'BytecodeDescriptor *'>
	primDescriptor := self generatorAt: byte0.
	
	((objectRepresentation isUnannotatableConstant: self ssTop)
	 and: [ objectRepresentation isUnannotatableConstant: (self ssValue: 1) ]) ifTrue:
		[self assert: primDescriptor isMapped not.
		 result := (orNot
					ifFalse: [self ssTop constant = (self ssValue: 1) constant]
					ifTrue: [self ssTop constant ~= (self ssValue: 1) constant])
									ifTrue: [objectMemory trueObject]
									ifFalse: [objectMemory falseObject].
		 self ssPop: 2.
		 ^self ssPushConstant: result].

	^objectRepresentation genInlinedIdenticalOrNotIfGuts: orNot