inline cacheing
rewriteCPICJumpAt: callSiteReturnAddress target: callTargetAddress
	"Rewrite the short jump instruction to jump to a new cpic case target. "
	<var: #callSiteReturnAddress type: #usqInt>
	<var: #callTargetAddress type: #usqInt>
	| callDistance |
	callDistance := (callTargetAddress - callSiteReturnAddress) signedIntToLong.
	self assert: (callDistance < 256).
	objectMemory
		byteAt: callSiteReturnAddress - 1 put:  (callDistance  bitAnd: 16rFF).
	"self cCode: ''
		inSmalltalk: [cogit disassembleFrom: callSiteReturnAddress - 10 to: callSiteReturnAddress - 1]."
	^2