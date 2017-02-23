disassembly
lookupFrameOffset: anInteger
	(self class initializationOptions at: #tempNames ifAbsent: nil) ifNotNil:
		[:dict|
		 (self class initializationOptions at: #startpc ifAbsent: nil) ifNotNil:
			[:startpc|
			 (dict at: startpc + 1 ifAbsent: nil) ifNotNil:
				[:tempNames| | numArgs |
				 anInteger = FoxMFReceiver ifTrue:
					[^'self'].
				numArgs := self class initializationOptions at: #numArgs.
				1 to: tempNames size do:
					[:i|
					anInteger = (self frameOffsetOfTemporary: i - 1 numArgs: numArgs) ifTrue:
						[^tempNames at: i]]]]].
	^nil