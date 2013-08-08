utilities
outputAsmLabel: selector on: aStream
	| count |
	suppressAsmLabels ifTrue: [^self].
	asmLabelCounts isNil ifTrue:
		[asmLabelCounts := Dictionary new].
	count := asmLabelCounts
				at: selector
				put: 1 + (asmLabelCounts at: selector ifAbsent: [-1]).
	 aStream
		nextPutAll: 'VM_LABEL(';
		print: count;
		nextPutAll: (self cFunctionNameFor: selector);
		nextPut: $);
		nextPut: $;