inline cacheing
relocateMethodReferenceBeforeAddress: pc by: delta
	"We generate the method address using pc-relative addressing.
	 Simply check that rip-relative addressing is being used. c.f.
	 concretizeMoveCwR"
	<inline: true>
	self assert: ((objectMemory byteAt: pc - 6) = 16r8D
				and: [((objectMemory byteAt: pc - 5) bitOr: (self mod: 0 RM: 0 RO: 7)) = (self mod: ModRegInd RM: 5 RO: 7)])