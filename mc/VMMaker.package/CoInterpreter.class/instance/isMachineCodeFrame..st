frame access
isMachineCodeFrame: theFP 
	<var: #theFP type: #'char *'>
	^(stackPages longAt: theFP + FoxMethod) asUnsignedInteger < objectMemory startOfMemory