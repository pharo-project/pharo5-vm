compile abstract instructions
spanFor: descriptor at: pc exts: nExts in: aMethodObj
	"Compute the span (jump distance) for a particular bytecode, e.g. a backward branch or a block."
	<inline: true>
	<var: #descriptor type: #'BytecodeDescriptor *'>
	^self
		perform: descriptor spanFunction
		with: descriptor
		with: pc
		with: nExts
		with: aMethodObj