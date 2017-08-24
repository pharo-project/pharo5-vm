pharo primitives
fileOpenFile: cfile write: writeFlag
	"Open the FILE* as file. Answer the file oop."
	| file fileOop |
	<option: #PharoVM>
	<var: #file type: 'SQFile *'>
	<var: 'cfile' type: 'FILE *'>
	<export: true>
	fileOop := interpreterProxy instantiateClass: interpreterProxy classByteArray indexableSize: self fileRecordSize.
	file := self fileValueOf: fileOop.
	interpreterProxy failed
		ifFalse: [self cCode: 'sqFileFileOpen(file, cfile, writeFlag)' inSmalltalk: [file]].
	^ fileOop