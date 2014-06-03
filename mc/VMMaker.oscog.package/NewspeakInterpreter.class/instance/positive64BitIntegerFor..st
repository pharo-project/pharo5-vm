primitive support
positive64BitIntegerFor: integerValue

	| newLargeInteger value check |
	"Note - integerValue is interpreted as POSITIVE, eg, as the result of
		Bitmap>at:, or integer>bitAnd:."
	<var: 'integerValue' type: 'sqLong'>
 
	(self sizeof: integerValue) = 4 ifTrue: [^self positive32BitIntegerFor: integerValue].

  	self cCode: 'check = integerValue >> 32'.  "Why not run this in sim?"
	check = 0 ifTrue: [^self positive32BitIntegerFor: integerValue].
	
	newLargeInteger :=
		self instantiateSmallClass: (self splObj: ClassLargePositiveInteger) sizeInBytes: BaseHeaderSize + 8.
	0 to: 7 do: [:i |
		self cCode: 'value = ( integerValue >> (i * 8)) & 255'.
		self storeByte: i ofObject: newLargeInteger withValue: value].
	^ newLargeInteger