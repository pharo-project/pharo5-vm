inlining support
renameLabelsUsing: aDictionary
	"Rename all labels according to the old->new mappings of the given dictionary."

	aDictionary isEmpty ifTrue:
		[^self].
	labels := labels collect: [ :label | aDictionary at: label ifAbsent: [label]].

	parseTree nodesDo:
		[ :node |
		(node isGoTo and: [aDictionary includesKey: node label]) ifTrue:
			[node setLabel: (aDictionary at: node label)].
		(node isLabel and: [aDictionary includesKey: node label]) ifTrue:
			[node setLabel: (aDictionary at: node label)]]