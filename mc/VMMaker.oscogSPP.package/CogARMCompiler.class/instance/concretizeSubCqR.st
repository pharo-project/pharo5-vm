generate machine code - concretize
concretizeSubCqR
	"Will get inlined into concretizeAt: switch."
	"Try whether the quick constant is a small negative number. If it is, optimize."
	<var: #word type: #sqInt>
	<inline: true>
	| word |
	word := operands at: 0.
	self rotateable8bitImmediate: word
		ifTrue: [ :rot :immediate | | reg |
			reg := operands at: 1.
			self machineCodeAt: 0 put: (self subs: reg rn: reg imm: immediate ror: rot).
			^machineCodeSize := 4]
		ifFalse: [
			"before building a full load of a big constant, see if we can do an add of the constant negated"
			self rotateable8bitImmediate: word negated
				ifTrue: [ :rot :immediate | | reg |
					reg := operands at: 1.
					self machineCodeAt: 0 put: (self adds: reg rn: reg imm: immediate ror: rot).
					^machineCodeSize := 4]
				ifFalse: [^self concretizeDataOperationCwR: SubOpcode]].
	^0 "to keep Slang happy"