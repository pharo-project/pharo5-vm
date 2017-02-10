sista support
branchIf: reg isNotOop:  oop target: targetFixup
	<var: #targetFixUp type: #'AbstractInstruction *'>
	<inline: true>
	cogit CmpCq: oop R: reg.
	cogit JumpNonZero: targetFixup.
	^ 0