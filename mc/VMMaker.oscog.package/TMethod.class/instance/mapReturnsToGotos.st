transformations
mapReturnsToGotos
	"For super expansions inner returns must be mapped to gotos to prevent premature exit.
	 But this only works if no value is being returned.
	 Anything meaningful in the returned expression must be retained."

	| map label |
	map := Dictionary new.
	parseTree nodesDo:
		[:node|
		node isReturn ifTrue:
			[(node expression isVariable and: [#('self' 'nil') includes: node expression name])
				ifTrue:
					[map at: node put: (TGoToNode new
											setLabel: (label ifNil: [label := self unusedLabelForInlining: self]);
											yourself)]
				ifFalse: [self error: 'Cannot expand super node with inner return that answers a value!']]].
	label ifNotNil:
		[parseTree := parseTree replaceNodesIn: map.
		 parseTree setStatements: (parseTree statements asOrderedCollection
										addLast: (TLabeledCommentNode new
														setLabel: label;
														yourself);
										yourself)]