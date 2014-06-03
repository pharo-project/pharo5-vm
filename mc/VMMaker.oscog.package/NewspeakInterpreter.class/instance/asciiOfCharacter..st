indexing primitive support
asciiOfCharacter: characterObj  "Returns an integer object"

	<inline: false>
	self assertClassOf: characterObj is: (self splObj: ClassCharacter).
	self successful
		ifTrue: [^ self fetchPointer: CharacterValueIndex ofObject: characterObj]
		ifFalse: [^ ConstZero]  "in case some code needs an int"