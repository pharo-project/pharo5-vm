private
checkLabel: label
	fixLabels ifNotNil:
		[label isInteger
			ifTrue: [self error: 'one cannot use integers as labels in assembler mode. integers are interpreted as branch distances']
			ifFalse: [fixLabels := true]]