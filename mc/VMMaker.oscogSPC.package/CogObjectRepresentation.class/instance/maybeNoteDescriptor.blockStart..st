compilation
maybeNoteDescriptor: descriptor blockStart: blockStart
	"A hook for the object representation to set state in a blockStart during scanBlock:.
	 By default do nothing.  Subclasses that need to do something special will override."
	<var: #blockStart type: #'BlockStart *'>
	<var: #descriptor type: #'BytecodeDescriptor *'>
	<inline: true>