debug printing
printRegisterMask: registerMask on: aStream
	<doNotGenerate>
	| first |
	aStream nextPut: ${.
	registerMask = 0
		ifTrue:
			[aStream nextPutAll: 'NoReg']
		ifFalse:
			[first := true.
			 0 to: 31 do:
				[:reg|
				(registerMask anyMask: 1 << reg) ifTrue:
					[first ifFalse: [aStream space].
					 first := false.
					 aStream nextPutAll: (backEnd nameForRegister: reg)]]].
	aStream nextPut: $}; flush