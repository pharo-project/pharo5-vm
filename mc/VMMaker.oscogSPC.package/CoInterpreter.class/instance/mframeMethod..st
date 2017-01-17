frame access
mframeMethod: theFP
	<inline: true>
	<var: #theFP type: #'char *'>
	^(self frameMethodField: theFP) bitAnd: MFMethodMask