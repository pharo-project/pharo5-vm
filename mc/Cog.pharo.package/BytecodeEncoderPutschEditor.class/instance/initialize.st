initialize-release
initialize
	xlator := [:s|
			((((s allButFirst: 4) beginsWith: 'For') or: [((s allButFirst: 4) beginsWith: 'Except') or: [s fifth = $:]])
				ifTrue: [(s first: 4), 'Code', (s allButFirst: 4)]
				ifFalse: [(s first: 4), 'CodeFor', (s allButFirst: 4)]) copyReplaceAll: ':on:' with: ':encoder:'].
	xlation := Dictionary new.
	(((ParseNode withAllSubclasses removeAll: Encoder withAllSubclasses; yourself)
		inject: Set new
		into: [:s :c| s addAll: c selectors. s])
			select:
				[:s| ((s beginsWith: 'emit') or: [s beginsWith: 'size'])
					and: [(s includesSubstring: 'Code' caseSensitive: true) not]]) do:
					[:s|xlation at: s put: (xlator value: s) asSymbol].
	kwdxlation := Dictionary new.
	xlation keysAndValuesDo: [:k :v| kwdxlation at: k keywords first put: v keywords first]