converting
to: aString

	| newAEDesc result |
	newAEDesc := AEDesc new.
	result := self primAECoerceDesc: (DescType of: aString) to: newAEDesc.
	result isZero ifFalse: [^result].
	self dispose.
	self at: 1 put: (newAEDesc at: 1).
	self at: 2 put: (newAEDesc at: 2).
	^0