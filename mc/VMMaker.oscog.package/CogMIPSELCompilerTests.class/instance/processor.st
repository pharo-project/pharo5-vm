accessing
processor
	processor ifNil:
		[processor := MIPSELSimulator new].
	^processor