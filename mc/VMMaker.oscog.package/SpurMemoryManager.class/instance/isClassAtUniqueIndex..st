class table
isClassAtUniqueIndex: aClass
	"Answer if aClass exists at only one index in the class table.  Be careful not to
	 be misled by classes that have puns, such as Array."
	| expectedIndex |
	expectedIndex := self rawHashBitsOf: aClass.
	self classTableEntriesDo:
		[:entry :index|
		 (entry = aClass
		  and: [index ~= expectedIndex
		  and: [index > self lastClassIndexPun]]) ifTrue:
			[^false]].
	^true