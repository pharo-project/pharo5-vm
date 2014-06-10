translation
bytecodeTable
	| selectors |
	selectors := Set new.
	generatorTable object do:
		[:bytecodeDescriptor|
		selectors add: bytecodeDescriptor generator.
		bytecodeDescriptor spanFunction ifNotNil:
			[selectors add: bytecodeDescriptor spanFunction]].
	^selectors