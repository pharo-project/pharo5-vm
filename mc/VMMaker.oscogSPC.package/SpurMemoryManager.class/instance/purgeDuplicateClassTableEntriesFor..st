class table
purgeDuplicateClassTableEntriesFor: aClass
	"Given that either marking or allInstances has ensured that
	 all instances of aClass have the class's hash as their class
	 index, ensure aClass is in the table only at its hash (or a pun)."
	| expectedIndex |
	expectedIndex := self rawHashBitsOf: aClass.
	self classTableEntriesDo:
		[:entry :index|
		 (entry = aClass
		  and: [index ~= expectedIndex
		  and: [index > self lastClassIndexPun]]) ifTrue:
			[self classAtIndex: index put: nilObj.
			 index < classTableIndex ifTrue:
				[classTableIndex := index]]].
	"classTableIndex must never index the first page, which is reserved for classes known to the VM."
	self assert: classTableIndex >= (1 << self classTableMajorIndexShift)