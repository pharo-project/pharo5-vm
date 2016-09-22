file primitives
fileOpenFd: fd write: writeFlag
	"Open the fd as file. Answer the file oop."
	| file fileOop |
	<var: #file type: 'SQFile *'>
	<var: 'fd' type: 'int'>
	<export: true>
	fileOop := interpreterProxy instantiateClass: interpreterProxy classByteArray indexableSize: self fileRecordSize.
	file := self fileValueOf: fileOop.
	interpreterProxy failed
		ifFalse: [self cCode: 'sqFileFdOpen(file, fd, writeFlag)' inSmalltalk: [file]].
	^ fileOop