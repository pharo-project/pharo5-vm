directory primitives
primitiveDirectoryCreate

	| dirName dirNameIndex dirNameSize okToCreate |
	<var: #dirNameIndex type: 'char *'>
	<export: true>

	dirName := interpreterProxy stackValue: 0.
	(interpreterProxy isBytes: dirName) ifFalse:
		[^interpreterProxy primitiveFail].
	dirNameIndex := interpreterProxy firstIndexableField: dirName.
	dirNameSize := interpreterProxy byteSizeOf: dirName.
	"If the security plugin can be loaded, use it to check for permission.
	If not, assume it's ok"
	sCCPfn ~= 0 ifTrue:
		[okToCreate := self cCode: ' ((sqInt (*)(char *, sqInt))sCCPfn)(dirNameIndex, dirNameSize)'
							inSmalltalk: [true].
		 okToCreate ifFalse:
			[^interpreterProxy primitiveFail]].
	(self
		cCode: 'dir_Create(dirNameIndex, dirNameSize)'
		inSmalltalk: [self createDirectory: (interpreterProxy asString: dirNameIndex)]) ifFalse:
		[^interpreterProxy primitiveFail].
	interpreterProxy pop: 1