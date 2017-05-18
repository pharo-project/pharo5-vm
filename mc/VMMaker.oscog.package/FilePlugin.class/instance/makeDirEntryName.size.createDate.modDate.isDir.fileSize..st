directory primitives
makeDirEntryName: entryName size: entryNameSize
	createDate: createDate modDate: modifiedDate
	isDir: dirFlag fileSize: fileSize

	| modDateOop createDateOop nameString results stringPtr fileSizeOop |
	<var: 'entryName' type: 'char *'>
	<var: 'stringPtr' type:'char *'>
	<var: 'fileSize' type:'squeakFileOffsetType '>

	"allocate storage for results, remapping newly allocated
	 oops in case GC happens during allocation"
	interpreterProxy pushRemappableOop:
		(interpreterProxy instantiateClass: (interpreterProxy classString) indexableSize: entryNameSize).
	interpreterProxy pushRemappableOop: 
		(interpreterProxy positive32BitIntegerFor: createDate).
	interpreterProxy pushRemappableOop: 
		(interpreterProxy positive32BitIntegerFor: modifiedDate).
	interpreterProxy pushRemappableOop:
		(interpreterProxy positive64BitIntegerFor: fileSize).

	results := interpreterProxy instantiateClass: (interpreterProxy classArray) indexableSize: 5.

	fileSizeOop		:= interpreterProxy popRemappableOop.
	modDateOop	:= interpreterProxy popRemappableOop.
	createDateOop	:= interpreterProxy popRemappableOop.
	nameString		:= interpreterProxy popRemappableOop.

	"copy name into Smalltalk string"
	stringPtr := interpreterProxy firstIndexableField: nameString.
	0 to: entryNameSize - 1 do:
		[ :i |
		self cCode: [stringPtr at: i put: (entryName at: i)]
			inSmalltalk: [interpreterProxy storeByte: i ofObject: nameString withValue: (entryName at: i+1) asciiValue]].

	interpreterProxy
		storePointer: 0 ofObject: results withValue: nameString;
		storePointer: 1 ofObject: results withValue: createDateOop;
		storePointer: 2 ofObject: results withValue: modDateOop;
		storePointer: 3 ofObject: results withValue: (dirFlag
														ifTrue: [interpreterProxy trueObject]
														ifFalse: [interpreterProxy falseObject]);
		storePointer: 4 ofObject: results withValue: fileSizeOop.
	^results