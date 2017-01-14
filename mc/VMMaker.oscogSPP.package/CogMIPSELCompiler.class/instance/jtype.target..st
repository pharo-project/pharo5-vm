encoding
jtype: op target: target
	self assert: (op between: 0 and: 63).
	self assert: (target between: 0 and: 16r7FFFFFF).
	^(op << 26) bitOr: target