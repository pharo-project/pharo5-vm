generate machine code
concretizeCallR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| reg skip |
	reg := operands at: 0.
	(reg <= 7)
		ifTrue: [skip := 0]
		ifFalse: [skip := 1. machineCode at: 0 put: (self rexw: false r: 0 x: 0 b: reg). (skip := 1)].
			
	machineCode
		at: skip + 0 put: 16rFF;
		at: skip + 1 put: (self mod: ModReg RM: reg RO: 2).
	^machineCodeSize := 2