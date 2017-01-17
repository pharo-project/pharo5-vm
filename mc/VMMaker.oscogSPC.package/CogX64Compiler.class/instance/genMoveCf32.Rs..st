abstract instructions
genMoveCf32: constantFloat32 Rs: register
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	<var: #constantFloat32 type: #float>
	| inst |
	inst := cogit PushCw: constantFloat32 asIEEE32BitWord.
	cogit PopRs: register.
	^ inst