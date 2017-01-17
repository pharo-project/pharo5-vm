inlining
unusedLabelForInlining: sourceMethod
	^labels add: (self unusedLabelForInliningInto: sourceMethod)