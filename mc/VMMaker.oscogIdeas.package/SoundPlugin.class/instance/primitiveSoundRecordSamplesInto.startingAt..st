primitives
primitiveSoundRecordSamplesInto: buf startingAt: startWordIndex 
	"Record a buffer's worth of 16-bit sound samples."
	| bufSizeInBytes samplesRecorded bufPtr byteOffset bufLen |
	<var: #bufPtr type: #'char*'>
	self primitive: 'primitiveSoundRecordSamples'
		parameters: #(WordArray SmallInteger ).

	interpreterProxy failed ifFalse:
		[bufSizeInBytes := (interpreterProxy slotSizeOf: buf cPtrAsOop) * 4.
		 interpreterProxy success: (startWordIndex >= 1 and: [startWordIndex - 1 * 2 < bufSizeInBytes])].

	interpreterProxy failed ifFalse:[
		byteOffset := (startWordIndex - 1) * 2.
		bufPtr := (self cCoerce: buf to: 'char*') + byteOffset.
		bufLen := bufSizeInBytes - byteOffset.
		samplesRecorded := self cCode: 'snd_RecordSamplesIntoAtLength(bufPtr, 0, bufLen)' inSmalltalk:[bufPtr. bufLen. 0].
	].

	^ samplesRecorded asPositiveIntegerObj