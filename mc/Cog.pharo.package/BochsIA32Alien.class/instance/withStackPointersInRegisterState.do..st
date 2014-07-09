accessing-abstract
withStackPointersInRegisterState: registerState do: aBinaryBlock
	^aBinaryBlock value: (registerState at: 5) value: (registerState at: 6)