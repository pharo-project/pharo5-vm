class table
validClassTableHashes
	"Check the hashes of classes in the table.  The tricky thing here is that classes may be duplicated
	 in the table.  So each entry must be in the table at its hash, even if it is elsewhere in the table."

	self validClassTableRootPages ifFalse:
		[^false].

	self classTableEntriesDo:
		[:classOrNil :ignored| | hash |
		 (self isForwarded: classOrNil) ifTrue:
			[^0].
		  hash := self rawHashBitsOf: classOrNil.
		  hash = 0 ifTrue:
			[^false].
		  (self noCheckClassAtIndex: hash) ~= classOrNil ifTrue:
			[^false]].

	^true