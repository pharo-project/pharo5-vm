running
verifyTestData: fileName using: aBlock
	| rounds seed bytes float result in expected count bits |
	in := [FileStream readOnlyFileNamed: fileName] 
			on: FileDoesNotExistException 
			do:[:ex| ex return: nil].
	in ifNil:[^nil].
	count := bits := 0.
	bytes := ByteArray new: 8.
	[
		in binary.
		rounds := in nextNumber: 4.
		seed := in nextNumber: 4.
		random := Random seed: seed.
		float := Float basicNew: 2.
		expected := Float basicNew: 2.
		'Verifying test data from: ', fileName 
			displayProgressAt: Sensor cursorPoint 
			from: 1 to: rounds during:[:bar|
				1 to: rounds do:[:i|
					i \\ 10000 = 0 ifTrue:[bar value: i].
					[1 to: 8 do:[:j| bytes at: j put: (random nextInt: 256)-1].
					float basicAt: 1 put: (bytes unsignedLongAt: 1 bigEndian: true).
					float basicAt: 2 put: (bytes unsignedLongAt: 5 bigEndian: true).
					float isNaN] whileTrue.
					result := aBlock value: float.
					expected basicAt: 1 put: (in nextNumber: 4).
					expected basicAt: 2 put: (in nextNumber: 4).
					((expected isNaN and:[result isNaN]) or:[expected = result]) ifFalse:[
						(expected basicAt: 1) = (result basicAt: 1)
							ifFalse:[self error: 'Verification failure'].
						count := count + 1.
						bits := bits + ((expected basicAt: 2) - (result basicAt: 2)) abs.
					].
				].
			].
	] ensure:[in close].
	self assert: count = 0. "all the same"