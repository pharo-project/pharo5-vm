debug support
allObjectsSelect: objBlock
	"self allObjectsSelect: [:oop | (self baseHeader: oop) = 1234]"

	| oop selected |
	oop := objectMemory firstObject.
	selected := OrderedCollection new.
	[oop < objectMemory endOfMemory] whileTrue:
			[(objectMemory isFreeObject: oop)
				ifFalse: [(objBlock value: oop) ifTrue: [selected addLast: oop]].
			oop := objectMemory objectAfter: oop].
	^ selected