utilities
suppressAsmLabelsWhile: aBlock
	| oldSuppressAsmLabels |
	oldSuppressAsmLabels := suppressAsmLabels.
	suppressAsmLabels := true.
	^aBlock ensure: [suppressAsmLabels := oldSuppressAsmLabels]