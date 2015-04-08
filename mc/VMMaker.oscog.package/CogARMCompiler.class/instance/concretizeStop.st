generate machine code - concretize
concretizeStop
"generate a BKPT instruction. We could, given a good enough creative impulse and an over-active sense of humour, add some numerically encoded witticism to this instruction in bits 8-19 & 0-3. It has no effect on the execution but can be a way to specify which breakpoint has been hit etc."
	<inline: true>
	machineCode at: 0 put: (AL <<28 bitOr: (16r42 <<20 bitOr:(7<<4))).
	^machineCodeSize := 4