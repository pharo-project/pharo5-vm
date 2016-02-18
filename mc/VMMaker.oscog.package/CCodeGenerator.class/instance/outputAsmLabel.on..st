utilities
outputAsmLabel: selector on: aStream
	| count |
	suppressAsmLabels ifTrue: [^self].
	asmLabelCounts ifNil:
		[asmLabelCounts := Dictionary new].
	count := asmLabelCounts
				at: selector
				put: 1 + (asmLabelCounts at: selector ifAbsent: [-1]).
	 aStream
		nextPutAll: 'VM_LABEL(';
		nextPutAll: (self cFunctionNameFor: selector);
		nextPutAll: (count = 0 ifTrue: [''] ifFalse: [count printString]);
		nextPut: $);
		nextPut: $;