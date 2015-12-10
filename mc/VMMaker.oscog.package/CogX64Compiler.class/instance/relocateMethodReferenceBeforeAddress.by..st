inline cacheing
relocateMethodReferenceBeforeAddress: pc by: delta
	"We generate the method address using pc-relative addressing.
	 Simply check that rip-relative addressing is being used. c.f.
	 concretizeMoveCwR"
	<inline: true>
	self assert: (((objectMemory byteAt: pc - 6) = 16r8D "move"
				and: [((objectMemory byteAt: pc - 5) bitOr: (self mod: 0 RM: 0 RO: 7)) = (self mod: ModRegInd RM: 5 RO: 7)])
				or: [(objectMemory byteAt: pc - 8) = 16r8D "push"
				and: [((objectMemory byteAt: pc - 7) bitOr: (self mod: 0 RM: 0 RO: 7)) = (self mod: ModRegInd RM: 5 RO: 7)]])