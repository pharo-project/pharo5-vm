frame access
mframeIsBlockActivation: theFP "<Integer>"
	<inline: true>
	<var: #theFP type: #'char *'>
	^((self frameMethodField: theFP) bitAnd: MFMethodFlagIsBlockFlag) ~= 0