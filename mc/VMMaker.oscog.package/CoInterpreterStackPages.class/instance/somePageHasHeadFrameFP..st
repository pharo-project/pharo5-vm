assertions
somePageHasHeadFrameFP: theFP
	^pages anySatisfy: [:page| page headFP = theFP]