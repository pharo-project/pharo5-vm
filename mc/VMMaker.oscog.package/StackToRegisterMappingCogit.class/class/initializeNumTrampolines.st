class initialization
initializeNumTrampolines
	NumTrampolines := 52
						+ (NewspeakVM ifTrue: [18] ifFalse: [0])
						+ (BytecodeSetHasDirectedSuperSend ifTrue: [4] ifFalse: [0])