young referers
ensureInYoungReferrers: cogMethod
	<var: #cogMethod type: #'CogMethod *'>
	cogMethod cmRefersToYoung ifFalse:
		[self assert: (self occurrencesInYoungReferrers: cogMethod) = 0.
		 cogMethod cmRefersToYoung: true.
		 self addToYoungReferrers: cogMethod]