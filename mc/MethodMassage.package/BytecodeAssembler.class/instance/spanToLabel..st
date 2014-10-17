assembly
spanToLabel: label "<Association>"
	| labelIndex |
	labelIndex := label value.
	labelIndex ifNil:
		[labelIndex := code instructions identityIndexOf: label.
		 label value: labelIndex].
	^(sizes at: labelIndex) ifNotNil:
		[self totalSizeFrom: index + 1 to: labelIndex]