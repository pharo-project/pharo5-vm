primitives
primitiveMPEG3TotalVStreams: fileHandle
	| file result |

	"int mpeg3_total_vstreams(mpeg3_t *file)"
	<var: #file type: 'mpeg3_t * '>
	self primitive: 'primitiveMPEG3TotalVStreams'
		parameters: #(Oop).
	file := self mpeg3tValueOf: fileHandle.
	file = nil ifTrue: [^nil].
	self cCode: 'result = mpeg3_total_vstreams(file)'.
	^result asSmallIntegerObj
