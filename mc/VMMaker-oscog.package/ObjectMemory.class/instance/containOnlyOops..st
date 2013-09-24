become
containOnlyOops: array
	"Answer if the array does not contain a small integer. You 
	  can't become: SmallIntegers!"
	| fieldOffset |
	fieldOffset := self lastPointerOf: array.
	"same size as array2"
	[fieldOffset >= BaseHeaderSize] whileTrue:
		[(self isIntegerObject: (self longAt: array + fieldOffset)) ifTrue: [^ false].
		 fieldOffset := fieldOffset - BytesPerOop].
	^true