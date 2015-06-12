abstract instructions
DumpJumpLong: jumpTarget
	"Convenience conflation of JumpLong: & dumpLiterals for PIC generation.
	 Literals must be dumped early and often to keep each PIC case the same size."
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	| inst |
	<var: 'inst' type: #'AbstractInstruction *'>
	inst := self gen: JumpLong operand: jumpTarget asInteger.
	literalsManager dumpLiterals: false.
	^inst