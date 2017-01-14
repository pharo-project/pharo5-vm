generate machine code
concretizeMoveCqR
	"Will get inlined into concretizeAt: switch.
	 Note that for quick constants, xor reg,reg, movq r8 may be shorter.  But
	 we don't consider it worthwhile and so just provide concretizeMoveCwR."
	<inline: true>
	| reg |
	(operands at: 0) ~= 0 ifTrue:
		[^self concretizeMoveCwR].
	reg := operands at: 1.
	machineCode
		at: 0 put: 16r31;
		at: 1 put: (self mod: ModReg RM: reg RO: reg).
	^machineCodeSize := 2