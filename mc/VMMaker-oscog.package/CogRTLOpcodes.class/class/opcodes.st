accessing
opcodes
	"CogRTLOpcodes opcodes"
	"CogRTLOpcodes opcodes select:
		[:opcode|
		(Cogit organization listAtCategoryNamed: #'abstract instructions') noneSatisfy:
			[:s|
			(Cogit compiledMethodAt: s) literals anySatisfy:
				[:l|
				l isVariableBinding and: [l key = opcode]]]]"
	^(classPool keys reject:
		[:k|
		(#('First' 'Last' 'DPFP') anySatisfy: [:prefix| k beginsWith: prefix])
		or: [#('Reg' 'Min' 'Max') anySatisfy: [:postfix| k endsWith: postfix]]]) asArray sort