instance initialization
createCasesFromBraceNode: aTBraceNode
	"Answer a sequence of tuples of { labels. case } for a TBraceNode, making
	 sure to collect equivalent cases together under a signle sequence of labels."
	| casesToStrings stringsToLabels newCases |
	casesToStrings := Dictionary new.
	stringsToLabels := Dictionary new.
	newCases := OrderedCollection new: aTBraceNode caseLabels size.
	aTBraceNode caseLabels with: aTBraceNode cases do:
		[:label :case| | printString |
		printString := casesToStrings at: case put: case printString.
		(stringsToLabels at: printString ifAbsentPut: [OrderedCollection new]) addLast: label].

	aTBraceNode caseLabels with: aTBraceNode cases do:
		[:label :case| | printString labels |
		printString := casesToStrings at: case.
		label = (labels := (stringsToLabels at: printString) asArray) first ifTrue:
			[newCases addLast: { labels collect: [:ea| ea statements first]. case}]].

	^newCases