generate machine code - concretize
concretizeRetN
	<var: #offset type: #sqInt>
	| offset |
	offset := operands at: 0.
	self machineCodeAt: 0 put: (self jR: RA).
	offset = 0 
		ifTrue: [self machineCodeAt: 4 put: self nop "Delay slot"]
		ifFalse: [self machineCodeAt: 4 put: (self addiuR: SP R: SP C: offset) "We actually get to fill a delay slot!"].
	^machineCodeSize := 8