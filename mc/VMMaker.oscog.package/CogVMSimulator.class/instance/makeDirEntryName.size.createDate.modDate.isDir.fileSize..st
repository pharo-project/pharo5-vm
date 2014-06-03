file primitives
makeDirEntryName: entryName size: entryNameSize
	createDate: createDate modDate: modifiedDate
	isDir: dirFlag fileSize: fileSize

	| modDateOop createDateOop nameString results |
	<var: 'entryName' type: 'char *'>

	results			:= objectMemory instantiateClass: (objectMemory splObj: ClassArray) indexableSize: 5.
	nameString		:= objectMemory instantiateClass: (objectMemory splObj: ClassByteString) indexableSize: entryNameSize.
	createDateOop	:= self positive32BitIntegerFor: createDate.
	modDateOop	:= self positive32BitIntegerFor: modifiedDate.

	1 to: entryNameSize do:
		[ :i |
		objectMemory storeByte: i-1 ofObject: nameString withValue: (entryName at: i) asciiValue].

	objectMemory storePointerUnchecked: 0 ofObject: results withValue: nameString.
	objectMemory storePointerUnchecked: 1 ofObject: results withValue: createDateOop.
	objectMemory storePointerUnchecked: 2 ofObject: results withValue: modDateOop.
	dirFlag
		ifTrue: [ objectMemory storePointerUnchecked: 3 ofObject: results withValue: objectMemory trueObject ]
		ifFalse: [ objectMemory storePointerUnchecked: 3 ofObject: results withValue: objectMemory falseObject ].
	objectMemory storePointerUnchecked: 4 ofObject: results withValue: (objectMemory integerObjectOf: fileSize).
	^ results