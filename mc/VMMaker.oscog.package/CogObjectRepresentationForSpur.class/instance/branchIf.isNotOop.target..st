sista support
branchIf: reg isNotOop:  oop target: targetFixUp
	<var: #targetFixUp type: #'AbstractInstruction *'>
	<inline: true>
	cogit CmpCq: oop R: reg.
	cogit JumpNonZero: targetFixUp.
	^0