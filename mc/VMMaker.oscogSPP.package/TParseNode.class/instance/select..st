enumerating
select: aBlock
	| nodes |
	nodes := OrderedCollection new.
	self nodesDo: [:n| (aBlock value: n) ifTrue: [nodes add: n]].
	^nodes