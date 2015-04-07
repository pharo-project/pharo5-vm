class initialization
initializeMiscConstants
	super initializeMiscConstants.
	NumTrampolines := 53
						+ (NewspeakVM ifTrue: [18] ifFalse: [0])
						+ (BytecodeSetHasDirectedSuperSend ifTrue: [4] ifFalse: [0])