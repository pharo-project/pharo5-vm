young referers
addToYoungReferrers: cogMethod
	<var: #cogMethod type: #'CogMethod *'>
	self assert: youngReferrers <= limitAddress.
	self assert: (self occurrencesInYoungReferrers: cogMethod) = 0.
	self assert: cogMethod cmRefersToYoung.
	(self asserta: self roomOnYoungReferrersList) ifFalse:
		[self error: 'no room on youngReferrers list'].
	youngReferrers := youngReferrers - BytesPerWord.
	objectMemory longAt: youngReferrers put: cogMethod asUnsignedInteger