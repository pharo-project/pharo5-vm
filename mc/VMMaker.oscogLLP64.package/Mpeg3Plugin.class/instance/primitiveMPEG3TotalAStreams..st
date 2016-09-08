primitives
primitiveMPEG3TotalAStreams: fileHandle
	| file result |

	"int mpeg3_total_astreams(mpeg3_t *file)"
	<var: #file type: 'mpeg3_t * '>
	self primitive: 'primitiveMPEG3TotalAStreams'
		parameters: #(Oop).
	file := self mpeg3tValueOf: fileHandle.
	file = nil ifTrue: [^0].
	self cCode: 'result = mpeg3_total_astreams(file)'.
	^result asSmallIntegerObj
