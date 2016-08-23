bytecode generator support
genEqualsEqualsComparisonArgIsConstant: argIsConstant rcvrIsConstant: rcvrIsConstant argReg: argReg rcvrReg: rcvrReg
	"Generates the Cmp instruction for #==. The instruction is different if one of the operands is a constant.
	In the case of the v3 memory manager, the constant could be annotable." 
	<inline: true>
	argIsConstant 
		ifTrue: [ self genCmpConstant: self ssTop constant R: rcvrReg ]
		ifFalse: [ rcvrIsConstant
			ifTrue: [ self genCmpConstant: (self ssValue: 1) constant R: argReg ]
			ifFalse: [ self CmpR: argReg R: rcvrReg ] ].