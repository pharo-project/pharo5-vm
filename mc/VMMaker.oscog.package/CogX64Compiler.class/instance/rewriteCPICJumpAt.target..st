inline cacheing
rewriteCPICJumpAt: addressFollowingJump target: jumpTargetAddr
	"Rewrite the short jump instruction to jump to a new cpic case target. "
	<var: #addressFollowingJump type: #usqInt>
	<var: #jumpTargetAddr type: #usqInt>
	<var: #callDistance type: #sqInt> "prevent type inference for avoiding warning on abs"
	| callDistance |
	callDistance := jumpTargetAddr - addressFollowingJump.
	self assert: callDistance abs < 128.
	objectMemory
		byteAt: addressFollowingJump - 1
		put:  (callDistance bitAnd: 16rFF).
	"self cCode: ''
		inSmalltalk: [cogit disassembleFrom: addressFollowingJump - 10 to: addressFollowingJump - 1]."