primitives
primitiveMPEG3GetFrame: fileHandle stream: aNumber
	| file result |

	"long mpeg3_get_frame(mpeg3_t *file,int stream)"
	<var: #file type: 'mpeg3_t * '>
	self primitive: 'primitiveMPEG3GetFrame'
		parameters: #(Oop SmallInteger).

	file := self mpeg3tValueOf: fileHandle.
	file = nil ifTrue: [^0].
	aNumber < 0 ifTrue: [interpreterProxy success: false. ^nil].
	aNumber >= (self cCode: 'result = mpeg3_total_vstreams(file)') ifTrue: [
		interpreterProxy success: false.  ^0 ].

	self cCode: 'result = mpeg3_get_frame(file,aNumber)'.
	^result asOop: Float.
