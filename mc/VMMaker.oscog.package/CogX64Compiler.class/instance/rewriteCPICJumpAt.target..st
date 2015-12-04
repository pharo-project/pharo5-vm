inline cacheing
rewriteCPICJumpAt: addressFollowingJump target: jumpTargetAddress
	"Rewrite the short jump instruction to jump to a new cpic case target. "
	<var: #addressFollowingJump type: #usqInt>
	<var: #jumpTargetAddress type: #usqInt>
	| callDistance |
	callDistance := jumpTargetAddress - addressFollowingJump.
	self assert: callDistance abs < 128.
	objectMemory
		byteAt: addressFollowingJump - 1
		put:  (callDistance bitAnd: 16rFF).
	"self cCode: ''
		inSmalltalk: [cogit disassembleFrom: addressFollowingJump - 10 to: addressFollowingJump - 1]."
	^2