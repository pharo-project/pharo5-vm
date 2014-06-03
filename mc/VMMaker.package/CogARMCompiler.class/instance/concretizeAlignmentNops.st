generate machine code - concretize
concretizeAlignmentNops
	<inline: true>
	"fill any slots with NOPs - in this case mov  r0, r0 - which is the NOP I always used to use"
	self assert: machineCodeSize \\ 4 = 0.
	0 to: machineCodeSize - 1 by: 4 do:
		[:p| machineCode 
			at: p put: 16r0;
			at: p+1 put: 16r0;
			at: p+2 put: 16rA0;
			at: p+3 put: 16rE1]