primitives
primitiveMPEG3DropFrames: fileHandle frames: aFrameNumber stream: aNumber
	| file result |

	"int mpeg3_drop_frames(mpeg3_t *file, long frames, int stream)"
	<var: #file type: 'mpeg3_t * '>
	self primitive: 'primitiveMPEG3DropFrames'
		parameters: #(Oop SmallInteger SmallInteger).

	file := self mpeg3tValueOf: fileHandle.
	file = nil ifTrue: [^0].
	aNumber < 0 ifTrue: [interpreterProxy success: false. ^nil].
	aNumber >= (self cCode: 'result = mpeg3_total_vstreams(file)') ifTrue: [
		interpreterProxy success: false.  ^0 ].


	self cCode: 'result = mpeg3_drop_frames(file,aFrameNumber,aNumber)'.
	^result asSmallIntegerObj
