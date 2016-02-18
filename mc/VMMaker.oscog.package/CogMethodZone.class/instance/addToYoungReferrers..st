young referers
addToYoungReferrers: cogMethod
	<var: #cogMethod type: #'CogMethod *'>
	self assert: youngReferrers <= limitAddress.
	self assert: (self occurrencesInYoungReferrers: cogMethod) = 0.
	self assert: cogMethod cmRefersToYoung.
	self assert: (youngReferrers <= limitAddress
				and: [youngReferrers >= (limitAddress - (methodCount * objectMemory wordSize))]).
	(self asserta: limitAddress - (methodCount * objectMemory wordSize) >= mzFreeStart) ifFalse:
		[self error: 'no room on youngReferrers list'].
	youngReferrers := youngReferrers - objectMemory wordSize.
	objectMemory longAt: youngReferrers put: cogMethod asUnsignedInteger