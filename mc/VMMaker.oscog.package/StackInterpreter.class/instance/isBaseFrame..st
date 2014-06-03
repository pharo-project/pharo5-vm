frame access
isBaseFrame: theFP
	"A base frame (first frame in a stack page) is so marked by having a null saved fp."
	<inline: true>
	<var: #theFP type: #'char *'>
	^(stackPages longAt: theFP + FoxSavedFP) == 0