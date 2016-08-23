class initialization
initializeNumTrampolines
	NumTrampolines := self numTrampolines
						+ self objectRepresentationClass numTrampolines
						+ (NewspeakVM ifTrue: [18] ifFalse: [0])
						+ (BytecodeSetHasDirectedSuperSend ifTrue: [4] ifFalse: [0])