disassembly
printRegisterMapOn: aStream
	<doNotGenerate>
	| map n |
	map := backEnd generalPurposeRegisterMap.
	n := 0.
	map keys sort
		do:	[:regName| | abstractName |
			abstractName := CogRTLOpcodes nameForRegister: (backEnd abstractRegisterForConcreteRegister: (map at: regName)).
			aStream nextPutAll: abstractName; nextPutAll: ' => '; nextPutAll: regName]
		separatedBy: [(n := n + 1) \\ 4 = 0 ifTrue: [aStream cr] ifFalse: [aStream tab]].
	aStream cr; flush