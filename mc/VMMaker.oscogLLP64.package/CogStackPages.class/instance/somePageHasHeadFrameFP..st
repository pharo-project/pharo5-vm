assertions
somePageHasHeadFrameFP: theFP
	<doNotGenerate>
	^pages anySatisfy: [:page| page headFP = theFP]
