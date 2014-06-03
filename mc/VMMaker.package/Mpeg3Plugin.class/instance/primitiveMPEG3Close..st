primitives
primitiveMPEG3Close: fileHandle
	| file index |

	"int mpeg3_close(mpeg3_t *file)"
	<var: #file type: 'mpeg3_t * '>
	<var: #index type: 'mpeg3_t ** '>
	self primitive: 'primitiveMPEG3Close'
		parameters: #(Oop).
	file := self mpeg3tValueOf: fileHandle.
	file = nil ifTrue: [^nil].
	self cCode: 'removeFileEntry(file); mpeg3_close(file)'.
	index := self cCoerce: (interpreterProxy firstIndexableField: fileHandle)
						to: 'mpeg3_t **'.
	self cCode: '*index = 0'.
