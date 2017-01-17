comparing
isSameAs: aTParseNode
	(aTParseNode isSend
	 and: [selector == aTParseNode selector
	 and: [receiver isSameAs: aTParseNode receiver]]) ifFalse:
		[^false].
	arguments with: aTParseNode args do:
		[:a :b|
		(a isSameAs: b) ifFalse:
			[^false]].
	^true