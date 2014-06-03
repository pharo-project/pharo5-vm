primitives
primitiveSoundStop
	"Stop double-buffered sound output."

	self primitive: 'primitiveSoundStop'.

	self cCode: 'snd_Stop()'.  "leave rcvr on stack"