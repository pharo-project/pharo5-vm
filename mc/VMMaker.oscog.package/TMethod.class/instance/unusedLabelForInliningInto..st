inlining
unusedLabelForInliningInto: targetMethod

	| usedLabels |
	usedLabels := labels copy.
	usedLabels addAll: targetMethod labels.
	^self unusedNamePrefixedBy: 'l' avoiding: usedLabels