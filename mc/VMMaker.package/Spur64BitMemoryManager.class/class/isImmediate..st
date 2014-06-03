simulation only
isImmediate: anObject
	self flag: 'The float range is close but probably wrong. Revisit when immediate floats are implemented'.
	^anObject class == SmallInteger
	  or: [anObject class == Character
	  or: [anObject class == Float and: [anObject exponent between: -128 and: 127]]]