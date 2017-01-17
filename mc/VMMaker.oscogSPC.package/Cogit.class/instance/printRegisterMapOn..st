disassembly
printRegisterMapOn: aStream
	<doNotGenerate>
	| map n |
	map := backEnd generalPurposeRegisterMap.
	n := 0.
	(map keys asSortedCollection: [:a :b| (map at: a) < (map at: b)])
		do:	[:regName| | abstractName |
			abstractName := backEnd nameForRegister: (map at: regName).
			aStream nextPutAll: abstractName; nextPutAll: ' => '; nextPutAll: regName]
		separatedBy: [(n := n + 1) \\ 4 = 0 ifTrue: [aStream cr] ifFalse: [aStream tab]].
	aStream cr; flush