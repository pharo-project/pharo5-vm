debug support
allObjectsSelect: objBlock
	"self allObjectsSelect: [:oop | (self baseHeader: oop) = 1234]"

	| selected |
	selected := OrderedCollection new.
	objectMemory allObjectsDoSafely:
		[:oop| (objBlock value: oop) ifTrue: [selected addLast: oop]].
	^ selected