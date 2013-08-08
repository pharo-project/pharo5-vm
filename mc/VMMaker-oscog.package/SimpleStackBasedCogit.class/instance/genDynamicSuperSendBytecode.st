bytecode generators
genDynamicSuperSendBytecode
	^self genSendDynamicSuper: (self getLiteral: byte2) numArgs: byte1