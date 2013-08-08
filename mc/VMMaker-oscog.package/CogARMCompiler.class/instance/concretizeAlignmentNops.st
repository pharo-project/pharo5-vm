generate machine code - concretize
concretizeAlignmentNops
	<inline: true>
	self assert: machineCodeSize \\ 4 = 0.
	0 to: machineCodeSize - 1 by: 4 do:
		[:p| objectMemory 
			byteAt: p put: 16r01;
			byteAt: p+1 put: 16r10;
			byteAt: p+2 put: 16rA0;
			byteAt: p+3 put: 16rE1]