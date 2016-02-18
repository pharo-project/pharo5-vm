testing
is8BitValue: constant ifTrue: trueAlternativeBlock	ifFalse: falseAlternativeBlock
	"For extended LDR and STR for half & double, there is an instruction allowing for one instruction encoding if the offset is encodable in 8 bit."
	<inline: true>
	constant abs <= 255 "(2 raisedTo: 8)-1"
		ifTrue:
			[constant >= 0 
				ifTrue: [trueAlternativeBlock value: 1 value: constant]
				ifFalse: [trueAlternativeBlock value: 0 value: constant abs]]
		ifFalse: falseAlternativeBlock