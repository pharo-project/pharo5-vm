constant support
genMoveNilR: reg
	<inline: true>
	^ self genMoveConstant: objectMemory nilObject R: reg
	