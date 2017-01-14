initialization
extraVariableName: root
	extraVariableNumber := extraVariableNumber
								ifNil: [0]
								ifNotNil: [extraVariableNumber + 1].
	^root, extraVariableNumber printString