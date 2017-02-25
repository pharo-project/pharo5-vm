accessing
numTrampolines
	^super numTrampolines
	 + (SistaV1BytecodeSet
		ifTrue: [8] "(small,large)x(method,block,fullBlock) context creation,
					 ceStoreCheckContextReceiverTrampoline and ceScheduleScavengeTrampoline"
		ifFalse: [6] "(small,large)x(method,block) context creation, 
					 ceStoreCheckContextReceiverTrampoline and ceScheduleScavengeTrampoline")
	 + ((initializationOptions at: #IMMUTABILITY ifAbsent: [false])
		ifTrue: [NumStoreTrampolines]
		ifFalse: [0])
	 + ((initializationOptions at: #SistaVM ifAbsent: [false])
		ifTrue: [1] "newHash"
		ifFalse: [0])