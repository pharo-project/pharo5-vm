primitives
primitiveMPEG3GetTime: fileHandle 
	| file result |

	"double mpeg3_get_time(mpeg3_t *file)"
	<var: #result type: 'double '>
	<var: #file type: 'mpeg3_t * '>
	self primitive: 'primitiveMPEG3GetTime'
		parameters: #(Oop).
	file := self mpeg3tValueOf: fileHandle.
	file = nil ifTrue: [^nil].
	self cCode: 'result = mpeg3_get_time(file)'.
	^result asOop: Float.
