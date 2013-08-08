initialization
recordGeneratedRunTime: aString address: address
	<var: #aString type: #'char *'>
	trampolineAddresses
		at: trampolineTableIndex put: aString;
		at: trampolineTableIndex + 1 put: (self cCoerceSimple: address to: #'char *').
	trampolineTableIndex := trampolineTableIndex + 2