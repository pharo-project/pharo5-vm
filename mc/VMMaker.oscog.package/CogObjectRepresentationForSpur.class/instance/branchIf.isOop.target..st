sista support
branchIf: reg isOop:  oop target: targetFixup
	<var: #targetFixUp type: #'AbstractInstruction *'>
	<inline: true>
	cogit CmpCq: oop R: reg.
	cogit JumpZero: targetFixup.
	^ 0