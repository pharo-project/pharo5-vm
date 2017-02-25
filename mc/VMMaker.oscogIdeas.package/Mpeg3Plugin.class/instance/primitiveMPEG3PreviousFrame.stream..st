primitives
primitiveMPEG3PreviousFrame: fileHandle stream: aNumber
	| file result |

	"int mpeg3_previous_frame(mpeg3_t *file, int stream)"
	<var: #file type: 'mpeg3_t * '>
	self primitive: 'primitiveMPEG3PreviousFrame'
		parameters: #(Oop SmallInteger).

	file := self mpeg3tValueOf: fileHandle.
	aNumber < 0 ifTrue: [interpreterProxy success: false. ^nil].
	file = nil ifTrue: [^nil].
	aNumber >= (self cCode: 'result = mpeg3_total_vstreams(file)') ifTrue: [
		interpreterProxy success: false.  ^0 ].


	self cCode: 'result = mpeg3_previous_frame(file,aNumber)'.
	^result asSmallIntegerObj
