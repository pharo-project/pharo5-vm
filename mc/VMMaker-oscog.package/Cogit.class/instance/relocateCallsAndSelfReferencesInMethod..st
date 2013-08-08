compaction
relocateCallsAndSelfReferencesInMethod: cogMethod
	<var: #cogMethod type: #'CogMethod *'>
	| delta |
	delta := cogMethod objectHeader signedIntFromLong.
	backEnd relocateCallBeforeReturnPC: cogMethod asInteger + missOffset by: delta negated.
	self mapFor: cogMethod
		performUntil: #relocateIfCallOrMethodReference:mcpc:delta:
		arg: delta