debug support
allObjectsSelect: objBlock
	"self allObjectsSelect: [:oop | (self baseHeader: oop) = 1234]"

	| oop selected |
	oop := self firstObject.
	selected := OrderedCollection new.
	[oop < endOfMemory] whileTrue:
			[(self isFreeObject: oop)
				ifFalse: [(objBlock value: oop) ifTrue: [selected addLast: oop]].
			oop := self objectAfter: oop].
	^ selected