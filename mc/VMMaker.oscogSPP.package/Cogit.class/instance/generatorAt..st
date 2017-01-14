compile abstract instructions
generatorAt: index
	<cmacro: '(index) (&generatorTable[index])'>
	<returnTypeC: #'BytecodeDescriptor *'>
	^generatorTable at: index