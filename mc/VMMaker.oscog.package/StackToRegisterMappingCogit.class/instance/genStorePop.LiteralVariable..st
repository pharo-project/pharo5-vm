bytecode generator support
genStorePop: popBoolean LiteralVariable: litVarIndex
	<inline: false>
	self 
		cppIf: IMMUTABILITY
		ifTrue: [ ^ self genImmutabilityCheckStorePop: popBoolean LiteralVariable: litVarIndex ]
		ifFalse: [ ^ self genVanillaStorePop: popBoolean LiteralVariable: litVarIndex ]
		