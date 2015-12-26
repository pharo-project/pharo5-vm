generate machine code - concretize
concretizeMoveCqR
	"Will get inlined into concretizeAt: switch."
	"If the quick constant is in fact a shiftable 8bit, generate the apropriate MOV, otherwise do what is necessary for a whole word."
	<var: #word type: #sqInt>
	<inline: true>
	|word reg|
	word := operands at: 0.
	reg := operands at: 1.
	self 
		rotateable8bitImmediate: word 
		ifTrue: [:rot :immediate |
			self machineCodeAt: 0 put: (self mov: reg imm: immediate ror: rot).
			^machineCodeSize := 4]
		ifFalse: [|invVal|
			word <0
				ifTrue:[invVal := -1 - word]
				ifFalse:[invVal := word bitInvert32].
			self rotateable8bitImmediate: invVal
				ifTrue: [ :rot :immediate |
					self machineCodeAt: 0 put: (self mvn: reg imm: immediate ror: rot).
					^machineCodeSize := 4]
				ifFalse: [^self concretizeMoveCwR]].
	^0 "to keep Slang happy"