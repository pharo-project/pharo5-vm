accessing
numTrampolines
	^super numTrampolines
	 + 6 "(small,large)x(method,block) context creation, ceStoreCheckContextReceiverTrampoline and ceScheduleScavengeTrampoline"
	 + ((initializationOptions at: #IMMUTABILITY ifAbsent: [false])
		ifTrue: [NumStoreTrampolines]
		ifFalse: [0])