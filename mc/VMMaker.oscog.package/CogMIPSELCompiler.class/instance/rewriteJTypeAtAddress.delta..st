inline cacheing
rewriteJTypeAtAddress: mcpc delta: delta
	| target |
	target := self targetFromJTypeAtAddress: mcpc.
	target := target + delta.
	self rewriteJTypeAtAddress: mcpc target: target.