stack pages
setHeadFP: theFP andSP: theSP inPage: thePage
	<inline: true>
	<asmLabel: false>
	<var: #theFP type: #'char *'>
	<var: #theSP type: #'char *'>
	<var: #thePage type: #'StackPage *'>
	self assert: theSP < theFP.
	self assert: (theSP < thePage baseAddress
				and: [theSP > (thePage realStackLimit - LargeContextSize)]).
	self assert: (theFP < thePage baseAddress
				and: [theFP > (thePage realStackLimit - (LargeContextSize / 2))]).
	thePage headFP: theFP; headSP: theSP