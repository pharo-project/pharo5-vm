inlining
shouldIncorporatePragmaFromSuperMethod: aPragma
	(properties includesKey: aPragma keyword) ifFalse:
		[^true].
	((aPragma keyword beginsWith: #var:)
	  and: [properties pragmas noneSatisfy:
			[:p|
			(p keyword beginsWith: #var:)
			and: [(p argumentAt: 1) = (aPragma argumentAt: 1)]]]) ifTrue:
		[^true].
	^false