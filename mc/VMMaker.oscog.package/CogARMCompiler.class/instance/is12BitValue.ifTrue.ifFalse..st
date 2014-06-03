testing
is12BitValue: constant ifTrue: trueAlternativeBlock	ifFalse: falseAlternativeBlock
	"For LDR and STR, there is an instruction allowing for one instruction encoding if the offset is encodable in 12 bit."
	constant abs <= 4095 "(2 raisedTo: 12)-1"
		ifTrue: [
			constant >= 0 
				ifTrue: [trueAlternativeBlock value: 1 value: constant]
				ifFalse: [trueAlternativeBlock value: 0 value: constant abs]]
		ifFalse: falseAlternativeBlock