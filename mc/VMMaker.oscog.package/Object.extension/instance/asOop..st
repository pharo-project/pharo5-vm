*VMMaker-translation support
asOop: aClass

	(self class isVariable and: [self class instSize > 0])
		ifTrue: [self error: 'cannot auto-coerce indexable objects with named instance variables'].
	(aClass ccgCanConvertFrom: self)
		ifFalse: [self error: 'incompatible object for this coercion'].
	^(Notification new tag: #getSimulator; signal)
		ifNotNil: [:simulator| aClass ccg: simulator generateCoerceToOopFrom: self on: nil]
		ifNil: [self]