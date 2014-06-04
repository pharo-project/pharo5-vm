file primitives
primitiveFileRename

	| oldNamePointer newNamePointer oldNameIndex oldNameSize newNameIndex newNameSize  okToRename |
	<var: 'oldNameIndex' type: 'char *'>
	<var: 'newNameIndex' type: 'char *'>
	<export: true>

	newNamePointer := interpreterProxy stackValue: 0.
	oldNamePointer := interpreterProxy stackValue: 1.
	((interpreterProxy isBytes: newNamePointer)
			and: [interpreterProxy isBytes: oldNamePointer])
		ifFalse: [^interpreterProxy primitiveFail].
	newNameIndex := interpreterProxy firstIndexableField: newNamePointer.
	newNameSize := interpreterProxy byteSizeOf: newNamePointer.
	oldNameIndex := interpreterProxy firstIndexableField: oldNamePointer.
	oldNameSize := interpreterProxy byteSizeOf: oldNamePointer.
	"If the security plugin can be loaded, use it to check for rename permission.
	If not, assume it's ok"
	sCRFfn ~= 0
		ifTrue: [okToRename := self cCode: ' ((sqInt (*)(char *, sqInt))sCRFfn)(oldNameIndex, oldNameSize)'.
			okToRename
				ifFalse: [^interpreterProxy primitiveFail]].
	self
		sqFileRenameOld: oldNameIndex Size: oldNameSize
		New: newNameIndex Size: newNameSize.
	interpreterProxy failed
		ifFalse: [interpreterProxy pop: 2]