primitives
primitiveMPEG3FrameRate: fileHandle stream: aNumber
	| file result |

	"float mpeg3_frame_rate(mpeg3_t *file, int stream)"
	<var: #result type: 'double '>
	<var: #file type: 'mpeg3_t * '>
	self primitive: 'primitiveMPEG3FrameRate'
		parameters: #(Oop SmallInteger).

	file := self mpeg3tValueOf: fileHandle.
	file = nil ifTrue: [^0].
	aNumber < 0 ifTrue: [interpreterProxy success: false. ^nil].
	aNumber >= (self cCode: 'result = mpeg3_total_vstreams(file)') ifTrue: [
		interpreterProxy success: false.  ^0 ].


	self cCode: 'result =  mpeg3_frame_rate(file,aNumber)'.
	^result asOop: Float
