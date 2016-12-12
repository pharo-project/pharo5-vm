sista support
allImmediate: immediateMask branchIf: reg instanceOfBehaviors: arrayObj target: targetFixUp
	< inline: true>	
	<var: #targetFixUp type: #'AbstractInstruction *'>
	self assert: immediateMask = objectMemory tagMask.
	(self genJumpImmediate: reg) jmpTarget: targetFixUp.
	^0