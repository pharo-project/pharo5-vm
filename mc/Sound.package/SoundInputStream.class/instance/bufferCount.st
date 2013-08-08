accessing
bufferCount
	"Answer the number of sound buffers that have been queued."

	mutex ifNil: [^ 0].  "not recording"
	^mutex critical: [recordedBuffers size].
