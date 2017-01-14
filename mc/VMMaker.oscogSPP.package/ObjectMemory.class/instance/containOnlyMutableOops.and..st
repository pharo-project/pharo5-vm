become
containOnlyMutableOops: array1 and: array2 
	"Return true if neither array contains an immutable.
	 You may not be allowed to become: immutables."
	| fieldOffset |
	fieldOffset := self lastPointerOf: array1.
	"same size as array2"
	[fieldOffset >= self baseHeaderSize] whileTrue:
		[(self isOopImmutable: (self longAt: array1 + fieldOffset)) ifTrue: [^false].
		 (self isOopImmutable: (self longAt: array2 + fieldOffset)) ifTrue: [^false].
		 fieldOffset := fieldOffset - self wordSize].
	^true