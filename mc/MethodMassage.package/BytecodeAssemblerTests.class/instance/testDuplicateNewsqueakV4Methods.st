tests
testDuplicateNewsqueakV4Methods
	Smalltalk allClasses do:
		[:class|
		self testDuplicateMethodsFor: class
			if: [:method| method usesAlternateBytecodeSet].
		self testDuplicateMethodsFor: class class
			if: [:method| method usesAlternateBytecodeSet]]