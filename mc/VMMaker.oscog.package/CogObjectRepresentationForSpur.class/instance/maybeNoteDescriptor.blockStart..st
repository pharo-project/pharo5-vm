compilation
maybeNoteDescriptor: descriptor blockStart: blockStart
	"Override to note inst var refs in blocks.  Used to avoid checking
	 for forwarded receivers in blocks that don't refer to inst vars."
	<var: #blockStart type: #'BlockStart *'>
	<var: #descriptor type: #'BytecodeDescriptor *'>
	<inline: true>
	descriptor isInstVarRef ifTrue:
		[blockStart hasInstVarRef: true]