initialize-release
initialize
	memory := ByteArray new: 262144.
	objectMemory := self class objectMemoryClass new.
	coInterpreter := CoInterpreter new.
	coInterpreter
		instVarNamed: 'objectMemory'
			put: objectMemory;
		instVarNamed: 'primitiveTable'
			put: (CArrayAccessor on: CoInterpreter primitiveTable copy).
	variables := Dictionary new.
	#('stackLimit') do:
		[:l| self addressForLabel: l].
	self initializeObjectMap