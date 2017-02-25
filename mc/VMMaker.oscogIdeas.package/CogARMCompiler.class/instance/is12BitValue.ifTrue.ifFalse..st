testing
is12BitValue: constant ifTrue: trueAlternativeBlock	ifFalse: falseAlternativeBlock
	"For LDR and STR, there is an instruction allowing for one instruction encoding if the offset is encodable in signed 12 bit form. pass the trueBlock the value and a 1-bit flag to tell it the sign.
	The falseBlock can do whatever it needs to, typically building the constant as a full 32bit value and then ld/st with that as a register offset"
	<inline: true>
	constant abs <= 4095 "(2 raisedTo: 12)-1"
		ifTrue:
			[constant >= 0 
				ifTrue: [^trueAlternativeBlock value: 1 value: constant]
				ifFalse: [^trueAlternativeBlock value: 0 value: constant abs]]
		ifFalse: [^falseAlternativeBlock value]