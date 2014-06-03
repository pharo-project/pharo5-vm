simulation only
isImmediate: anObject
	^anObject class == SmallInteger
	  or: [anObject class == Character]