directory primitives
primitiveDirectoryDelete

	| dirName dirNameIndex dirNameSize okToDelete |
	<var: #dirNameIndex type: 'char *'>
	<export: true>

	dirName := interpreterProxy stackValue: 0.
	(interpreterProxy isBytes: dirName)
		ifFalse: [^interpreterProxy primitiveFail].
	dirNameIndex := interpreterProxy firstIndexableField: dirName.
	dirNameSize := interpreterProxy byteSizeOf: dirName.
	"If the security plugin can be loaded, use it to check for permission.
	If not, assume it's ok"
	sCDPfn ~= 0
		ifTrue: [okToDelete := self cCode: ' ((sqInt (*)(char *, sqInt))sCDPfn)(dirNameIndex, dirNameSize)' inSmalltalk: [false].
			okToDelete
				ifFalse: [^interpreterProxy primitiveFail]].
	(self
			cCode: 'dir_Delete(dirNameIndex, dirNameSize)'
			inSmalltalk: [false])
		ifFalse: [^interpreterProxy primitiveFail].
	interpreterProxy pop: 1