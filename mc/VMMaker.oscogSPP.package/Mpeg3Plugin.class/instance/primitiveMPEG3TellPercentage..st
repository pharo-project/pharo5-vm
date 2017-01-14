primitives
primitiveMPEG3TellPercentage: fileHandle
	| file result |

	"double mpeg3_tell_percentage(mpeg3_t *file)"
	<var: #result type: 'double '>
	<var: #file type: 'mpeg3_t * '>
	self primitive: 'primitiveMPEG3TellPercentage'
		parameters: #(Oop).
	file := self mpeg3tValueOf: fileHandle.
	file = nil ifTrue: [^nil].
	self cCode: 'result = mpeg3_tell_percentage(file)'.
	^result asOop: Float.
