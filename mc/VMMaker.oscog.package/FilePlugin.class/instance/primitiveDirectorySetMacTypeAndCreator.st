directory primitives
primitiveDirectorySetMacTypeAndCreator

	| creatorString typeString fileName creatorStringIndex typeStringIndex fileNameIndex fileNameSize okToSet |
	<var: 'creatorStringIndex' type: 'char *'>
	<var: 'typeStringIndex' type: 'char *'>
	<var: 'fileNameIndex' type: 'char *'>
	<export: true>

	creatorString := interpreterProxy stackValue: 0.
	typeString := interpreterProxy stackValue: 1.
	fileName := interpreterProxy stackValue: 2.
	((interpreterProxy isBytes: creatorString)
	 and: [(interpreterProxy isBytes: typeString)
	 and: [(interpreterProxy isBytes: fileName)
	 and: [(interpreterProxy byteSizeOf: creatorString) = 4
	 and: [(interpreterProxy byteSizeOf: typeString) = 4]]]]) ifFalse:
		[^interpreterProxy primitiveFail].
	creatorStringIndex := interpreterProxy firstIndexableField: creatorString.
	typeStringIndex := interpreterProxy firstIndexableField: typeString.
	fileNameIndex := interpreterProxy firstIndexableField: fileName.
	fileNameSize := interpreterProxy byteSizeOf: fileName.
	"If the security plugin can be loaded, use it to check for permission.
	If not, assume it's ok"
	sCSFTfn ~= 0 ifTrue:
		[okToSet := self
						cCode: '((sqInt (*)(char *, sqInt))sCSFTfn)(fileNameIndex, fileNameSize)'
						inSmalltalk: [true].
		 okToSet ifFalse:
			[^interpreterProxy primitiveFail]].
	(self
		cCode: 'dir_SetMacFileTypeAndCreator(fileNameIndex, fileNameSize, typeStringIndex, creatorStringIndex)'
		inSmalltalk: [true]) ifFalse:
			[^interpreterProxy primitiveFail].
	interpreterProxy pop: 3