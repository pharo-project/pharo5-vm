inline cacheing
rewriteJTypeAtAddress: mcpc delta: delta
	| oldTarget newTarget |
	oldTarget := self targetFromJTypeAtAddress: mcpc.
	newTarget := oldTarget + delta.
	self rewriteJTypeAtAddress: mcpc target: newTarget.