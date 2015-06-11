abstract instructions
DumpJumpLongZero: jumpTarget
	"Convenience conflation of JumpLongZero: & dumpLiterals for PIC generation.
	 Literals must be dumped early and often to keep each PIC case the same size."
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	| inst |
	<var: 'inst' type: #'AbstractInstruction *'>
	inst := self gen: JumpLongZero operand: jumpTarget asInteger.
	literalsManager dumpLiterals.
	^inst