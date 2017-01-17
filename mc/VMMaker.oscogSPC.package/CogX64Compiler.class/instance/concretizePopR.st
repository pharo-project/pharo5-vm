generate machine code
concretizePopR
	<inline: true>
	| reg |
	reg := operands at: 0.
	reg < 8 ifTrue:
		[machineCode at: 0 put: 16r58 + reg.
		^machineCodeSize := 1].
	machineCode
		at: 0 put: 16r41;
		at: 1 put: 16r58 + (reg - 8).
	^machineCodeSize := 2