accessing
numTrampolines
	^super numTrampolines
	 + (SistaV1BytecodeSet
		ifTrue: [9] "(small,large)x(method,block,fullBlock) context creation,
					 ceNewHashTrampoline, ceStoreCheckContextReceiverTrampoline and ceScheduleScavengeTrampoline"
		ifFalse: [7] "(small,large)x(method,block) context creation, 
					 ceNewHashTrampoline, ceStoreCheckContextReceiverTrampoline and ceScheduleScavengeTrampoline")
	 + ((initializationOptions at: #IMMUTABILITY ifAbsent: [false])
		ifTrue: [NumStoreTrampolines]
		ifFalse: [0])
	 + ((initializationOptions at: #SistaVM ifAbsent: [false])
		ifTrue: [1] "inline newHash"
		ifFalse: [0])