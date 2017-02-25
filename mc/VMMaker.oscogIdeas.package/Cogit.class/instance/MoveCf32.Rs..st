abstract instructions
MoveCf32: constantFloat32 Rs: register
	<inline: true>
	<var: #constantFloat32 type: #float>
	<returnTypeC: #'AbstractInstruction *'>
	^ backEnd genMoveCf32: constantFloat32 Rs: register