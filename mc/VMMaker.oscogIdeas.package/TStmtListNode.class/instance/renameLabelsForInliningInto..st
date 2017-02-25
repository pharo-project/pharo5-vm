inlining support
renameLabelsForInliningInto: aTMethod
	"TMethod already has a method for this; hijack it..."
	| labels |
	labels := OrderedCollection new.
	self nodesDo:
		[:node| node isLabel ifTrue: [labels add: node label]].
	TMethod new
		parseTree: self;
		labels: labels;
		renameLabelsForInliningInto: aTMethod