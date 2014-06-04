debug support
allObjectsSelect: objBlock
	"self allObjectsSelect: [:oop | (self baseHeader: oop) = 1234]"

	| selected |
	selected := OrderedCollection new.
	objectMemory allObjectsDoSafely:
		[:obj|
		(objBlock value: obj) ifTrue: [selected addLast: obj]].
	^selected