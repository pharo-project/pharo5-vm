bytecode generator support
genCmpArgIsConstant: argIsConstant rcvrIsConstant: rcvrIsConstant argReg: argReg rcvrReg: rcvrReg
	"Generates the Cmp instruction for the top two ssStack values. 
	ssTop is called the argument and ssValue: 1 is called the receiver.
	0 or 1 value on ssStack is a constant (but not 2). If a value is a constant, then noReg is passed as argReg or rcvrReg.
	The instruction is different if one of the operands is a constant.
	In the case of the v3 memory manager, the constant could be annotable."
	<inline: true>
	self assert: (argReg ~= NoReg or: [rcvrReg ~= NoReg]).
	argIsConstant 
		ifTrue: [ self genCmpConstant: self ssTop constant R: rcvrReg ]
		ifFalse: [ rcvrIsConstant
			ifTrue: [ self genCmpConstant: (self ssValue: 1) constant R: argReg ]
			ifFalse: [ self CmpR: argReg R: rcvrReg ] ].