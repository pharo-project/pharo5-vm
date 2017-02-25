generate machine code - concretize
concretizeMoveCqR
	<var: #word type: #sqInt>
	| word reg |
	word := operands at: 0.
	reg := operands at: 1.
	
	(word between: -16r8000 and: 16r7FFF) ifFalse: [^self concretizeMoveCwR].
	"Could also load up to 16rFFFF with ori or 16rXXXX0000 with lui"
	
	self machineCodeAt: 0 put: (self addiuR: reg R: ZR C: word).
	^machineCodeSize := 4