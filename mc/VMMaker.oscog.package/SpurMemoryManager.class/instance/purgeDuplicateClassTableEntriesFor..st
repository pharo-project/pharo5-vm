class table
purgeDuplicateClassTableEntriesFor: aClass
	"Given that either marking or allnstances has ensured that
	 all instances of aClass  have the class's hash as their class
	 index, ensure aClass is in the table only at its hash."
	| expectedIndex |
	expectedIndex := self rawHashBitsOf: aClass.
	self classTableEntriesDo:
		[:entry :index|
		 (entry = aClass and: [index ~= expectedIndex]) ifTrue:
			[self classAtIndex: index put: nilObj.
			 index < classTableIndex ifTrue:
				[classTableIndex := index]]]