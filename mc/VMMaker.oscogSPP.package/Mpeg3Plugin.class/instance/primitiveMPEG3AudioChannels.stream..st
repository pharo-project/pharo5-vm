primitives
primitiveMPEG3AudioChannels: fileHandle stream: aNumber
	| file result |

	"int mpeg3_audio_channels(mpeg3_t *file,int stream)"
	<var: #file type: 'mpeg3_t * '>
	self primitive: 'primitiveMPEG3AudioChannels'
		parameters: #(Oop SmallInteger).

	file := self mpeg3tValueOf: fileHandle.
	file = nil ifTrue: [^0].
	aNumber < 0 ifTrue: [interpreterProxy success: false. ^0].
	aNumber >= (self cCode: 'mpeg3_total_astreams(file)') ifTrue: [
		interpreterProxy success: false. ^0.
	].

	result := self cCode: 'mpeg3_audio_channels(file,aNumber)'.
	^result asSmallIntegerObj
