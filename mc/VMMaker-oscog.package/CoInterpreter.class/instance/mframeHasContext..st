frame access
mframeHasContext: theFP
	<inline: true>
	<var: #theFP type: #'char *'>
	^((self frameMethodField: theFP) bitAnd: MFMethodFlagHasContextFlag) ~= 0