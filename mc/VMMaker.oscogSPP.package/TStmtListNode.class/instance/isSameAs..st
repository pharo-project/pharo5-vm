testing
isSameAs: aTParseNode
	(aTParseNode isStmtList
	 and: [statements size = aTParseNode statements size]) ifFalse:
		[^false].
	statements with: aTParseNode statements do:
		[:mine :theirs|
		 (mine isSameAs: theirs) ifFalse:
			[^false]].
	^true