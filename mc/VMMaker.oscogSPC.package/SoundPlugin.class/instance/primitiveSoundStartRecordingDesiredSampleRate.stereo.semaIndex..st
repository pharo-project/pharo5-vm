primitives
primitiveSoundStartRecordingDesiredSampleRate: desiredSamplesPerSec stereo: stereoFlag semaIndex: semaIndex
	"Start recording sound with the given parameters."

	self primitive: 'primitiveSoundStartRecording'
		parameters: #(SmallInteger Boolean SmallInteger).
	self cCode: 'snd_StartRecording(desiredSamplesPerSec, stereoFlag, semaIndex)'