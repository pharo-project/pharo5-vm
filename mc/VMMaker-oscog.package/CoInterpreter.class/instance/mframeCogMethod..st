frame access
mframeCogMethod: theFP
	"Answer the Cog method for a machine code frame.  This may be
	 either a full CogMethod or merely a CogBlockMethod rump header."
	<var: #theFP type: #'char *'>
	<returnTypeC: #'CogBlockMethod *'>
	^self cCoerceSimple: (self mframeMethod: theFP) to: #'CogBlockMethod *'