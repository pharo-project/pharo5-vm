primitives
primitiveSoundStopRecording
	"Stop recording sound."

	self primitive: 'primitiveSoundStopRecording'.
	self cCode: 'snd_StopRecording()'.  "leave rcvr on stack"