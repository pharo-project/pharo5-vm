compile abstract instructions
nextBytecodePCFor: descriptor at: pc exts: nExts in: aMethodObj
	"Compute the distance to the logically subsequent bytecode, i.e. skip over blocks."
	<var: #descriptor type: #'BytecodeDescriptor *'>
	<inline: true>
	^pc
		+ descriptor numBytes
		+ (descriptor isBlockCreation
			ifTrue: [self spanFor: descriptor at: pc exts: nExts in: aMethodObj]
			ifFalse: [0])