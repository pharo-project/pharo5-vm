initialize-release
initialize
	memory := (VMBIGENDIAN
					ifTrue: [Bitmap]
					ifFalse: [LittleEndianBitmap]) new: 1024*1024/4.
	objectMemory := self class objectMemoryClass simulatorClass new.
	objectMemory memory: memory.
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