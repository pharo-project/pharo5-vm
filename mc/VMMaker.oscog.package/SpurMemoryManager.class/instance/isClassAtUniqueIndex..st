class table
isClassAtUniqueIndex: aClass
	"Answer if aClass exists at only one index in the class table."
	| expectedIndex |
	expectedIndex := self rawHashBitsOf: aClass.
	self classTableEntriesDo:
		[:entry :index|
		 (entry = aClass and: [index ~= expectedIndex]) ifTrue:
			[^false]].
	^true