enumerating
collect: aBlock
	| nodes |
	self halt. "This is a misnomer; should be deleted"
	nodes := OrderedCollection new.
	self nodesDo: [:n| (aBlock value: n) ifTrue: [nodes add: n]].
	^nodes