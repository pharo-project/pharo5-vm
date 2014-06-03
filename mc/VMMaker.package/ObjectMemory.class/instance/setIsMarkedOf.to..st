header access
setIsMarkedOf: objOop to: aBoolean
	| header |
	self assert: (self isFreeObject: objOop) not.
	header := self baseHeader: objOop.
	self
		baseHeader: objOop
		put: (aBoolean
				ifTrue: [header bitOr: MarkBit]
				ifFalse: [(header bitOr: MarkBit) - MarkBit])