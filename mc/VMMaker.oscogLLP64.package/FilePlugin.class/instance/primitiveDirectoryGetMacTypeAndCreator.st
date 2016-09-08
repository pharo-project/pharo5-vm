directory primitives
primitiveDirectoryGetMacTypeAndCreator

	| creatorString typeString fileName creatorStringIndex typeStringIndex fileNameIndex fileNameSize okToGet |
	<var: 'creatorStringIndex' type: 'char *'>
	<var: 'typeStringIndex' type: 'char *'>
	<var: 'fileNameIndex' type: 'char *'>
	<export: true>

	creatorString := interpreterProxy stackValue: 0.
	typeString := interpreterProxy stackValue: 1.
	fileName := interpreterProxy stackValue: 2.
	((interpreterProxy isBytes: creatorString)
			and: [(interpreterProxy byteSizeOf: creatorString) = 4])
		ifFalse: [^interpreterProxy primitiveFail].
	((interpreterProxy isBytes: typeString)
			and: [(interpreterProxy byteSizeOf: typeString) = 4])
		ifFalse: [^interpreterProxy primitiveFail].
	(interpreterProxy isBytes: fileName)
		ifFalse: [^interpreterProxy primitiveFail].
	creatorStringIndex := interpreterProxy firstIndexableField: creatorString.
	typeStringIndex := interpreterProxy firstIndexableField: typeString.
	fileNameIndex := interpreterProxy firstIndexableField: fileName.
	fileNameSize := interpreterProxy byteSizeOf: fileName.
	"If the security plugin can be loaded, use it to check for permission.
	If not, assume it's ok"
	sCGFTfn ~= 0
		ifTrue: [okToGet := self cCode: ' ((sqInt (*)(char *, sqInt))sCGFTfn)(fileNameIndex, fileNameSize)'.
			okToGet
				ifFalse: [^interpreterProxy primitiveFail]].
	(self
			cCode: 'dir_GetMacFileTypeAndCreator(fileNameIndex, fileNameSize, typeStringIndex, creatorStringIndex)'
			inSmalltalk: [true])
		ifFalse: [^interpreterProxy primitiveFail].
	interpreterProxy pop: 3