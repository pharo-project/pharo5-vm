callback support
lookupMethodNoMNUEtcInClass: class
	"Lookup.  Answer false on failure father than performing MNU processing etc."
	| currentClass dictionary |
	<inline: true>

	currentClass := class.
	[currentClass ~= nilObj] whileTrue:
		[dictionary := self fetchPointer: MethodDictionaryIndex ofObject: currentClass.
		(dictionary ~= nilObj
		 and: [self lookupMethodInDictionary: dictionary]) ifTrue:
			[^true].
		currentClass := self superclassOf: currentClass].

	^false