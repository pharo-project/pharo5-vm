abstract instructions
MoveCf64: constantFloat64 Rd: register
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	<var: #constantFloat64 type: #double>
	^ backEnd genMoveCf64: constantFloat64 Rd: register