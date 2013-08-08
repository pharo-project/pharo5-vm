*VMMaker-C translation
anyReturns: aSequenceOfNodes
	aSequenceOfNodes do:
		[:node|
		node nodesDo:
			[:n|
			n isReturn ifTrue:
				[^true]]].
	^false