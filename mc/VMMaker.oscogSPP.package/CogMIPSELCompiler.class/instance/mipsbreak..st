encoding - control
mipsbreak: code
	self assert: (code between: 0 and: 16rFFFFF).
	^(code << 6) bitOr: BREAK