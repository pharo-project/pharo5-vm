accessing
priorPc: val
"set the priorPC cached pc so it isn't random nonsense"
	^self unsignedLongAt: 609 put: val