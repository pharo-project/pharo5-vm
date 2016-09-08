utilities
addTypeForSelf
	"If self should be typed then add a suitable type declaration.
	 Preserve the flagging of an implicit self using the #implicit symbol as the fake type."
	self typeForSelf ifNotNil:
		[:typeForSelf|
		self declarationAt: 'self'
			put: (typeForSelf == #implicit
					ifTrue: [typeForSelf]
					ifFalse: [typeForSelf, ' self'])]