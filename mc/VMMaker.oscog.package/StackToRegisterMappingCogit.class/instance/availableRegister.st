simulation stack
availableRegister
	| reg |
	reg := self availableRegisterOrNil.
	reg ifNil: [self error: 'no available register'].
	^reg