file primitives
primitiveFileDelete

	| namePointer nameIndex nameSize  okToDelete |
	<var: 'nameIndex' type: 'char *'>
	<export: true>

	namePointer := interpreterProxy stackValue: 0.
	(interpreterProxy isBytes: namePointer)
		ifFalse: [^ interpreterProxy primitiveFail].
	nameIndex := interpreterProxy firstIndexableField: namePointer.
	nameSize := interpreterProxy byteSizeOf: namePointer.
	"If the security plugin can be loaded, use it to check for permission.
	If not, assume it's ok"
	sCDFfn ~= 0
		ifTrue: [okToDelete := self cCode: ' ((sqInt (*)(char *, sqInt))sCDFfn)(nameIndex, nameSize)' inSmalltalk: [true].
			okToDelete
				ifFalse: [^ interpreterProxy primitiveFail]].
	self
		sqFileDeleteName: nameIndex
		Size: nameSize.
	interpreterProxy failed
		ifFalse: [interpreterProxy pop: 1]