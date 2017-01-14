inlining
unusedLabelForInliningInto: targetMethod
	^self unusedNamePrefixedBy: 'l' avoiding: (targetMethod == self
												ifTrue: [labels]
												ifFalse: [labels copy
															addAll: targetMethod labels;
															yourself])