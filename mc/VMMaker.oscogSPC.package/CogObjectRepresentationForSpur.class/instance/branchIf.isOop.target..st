sista support
branchIf: reg isOop:  oop target: targetFixUp
	<var: #targetFixUp type: #'AbstractInstruction *'>
	<inline: true>
	cogit CmpCq: oop R: reg.
	cogit JumpZero: targetFixUp.
	^0