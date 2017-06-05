file primitives
fileOpenNewName: nameIndex size: nameSize secure: secureFlag 
	"Open the new named file, possibly checking security. Answer the file oop."
	| file fileOop okToOpen |
	<var: #file type: 'SQFile *'>
	<var: 'nameIndex' type: 'char *'>
	<export: true>
	fileOop := interpreterProxy instantiateClass: interpreterProxy classByteArray indexableSize: self fileRecordSize.
	file := self fileValueOf: fileOop.
	interpreterProxy failed
		ifFalse: [ secureFlag ifTrue: [
				"If the security plugin can be loaded, use it to check for permission.
				If not, assume it's ok"
				sCOFfn ~= 0 
					ifTrue: [
						okToOpen := self cCode: '((sqInt (*) (char *, sqInt, sqInt)) sCOFfn)(nameIndex, nameSize, true)' inSmalltalk:[true].
						okToOpen
							ifFalse: [interpreterProxy primitiveFail]]]].
	interpreterProxy failed
		ifFalse: [| exists |
			exists := false.
			self cCode: 'sqFileOpenNew(file, nameIndex, nameSize, &exists)' inSmalltalk: [file].
			(interpreterProxy failed
				and: [exists])
				ifTrue: [interpreterProxy primitiveFailFor: PrimErrInappropriate]].
	^ fileOop