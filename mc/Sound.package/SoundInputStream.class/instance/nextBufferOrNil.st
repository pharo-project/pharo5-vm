accessing
nextBufferOrNil
	"Answer the next input buffer or nil if no buffer is available."

	mutex ifNil: [^ nil].  "not recording"
	^mutex critical: [
		recordedBuffers size > 0
			ifTrue: [recordedBuffers removeFirst]
			ifFalse: [nil]].
