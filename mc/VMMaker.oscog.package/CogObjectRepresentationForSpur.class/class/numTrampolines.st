accessing
numTrampolines
	^super numTrampolines
	 + (SistaV1BytecodeSet
		ifTrue: [8] "(small,large)x(method,block,fullBlock) context creation,
					 ceStoreCheckContextReceiverTrampoline and ceScheduleScavengeTrampoline"
		ifFalse: [6] "(small,large)x(method,block) context creation,
					 ceStoreCheckContextReceiverTrampoline and ceScheduleScavengeTrampoline")
	 + NumStoreTrampolines "FIXME: the generated C code does not take into account whether IMMUTABILITY is defined to one or zero"
		"((initializationOptions at: #IMMUTABILITY ifAbsent: [false])
		ifTrue: [NumStoreTrampolines]
		ifFalse: [0])"