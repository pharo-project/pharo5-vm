tests-method map
innermostSubMethodFor: bcpc in: subMethods startingAt: index
	<doNotGenerate>
	| subMethod |
	^index <= subMethods size ifTrue:
		[subMethod := subMethods at: index.
		 (bcpc between: subMethod startpc and: subMethod endPC)
			ifTrue:
				[(self innermostSubMethodFor: bcpc in: subMethods startingAt: index + 1)
					ifNil: [subMethod]
					ifNotNil: [:innerSubMethod| innerSubMethod]]
			ifFalse:
				[self innermostSubMethodFor: bcpc in: subMethods startingAt: index + 1]]