C code generation
isSelfReference: varNode in: aCodeGen
	^(varNode name beginsWith: 'self')
	  and: [varNode name = 'self' or: [varNode name beginsWith: 'self_in_']]