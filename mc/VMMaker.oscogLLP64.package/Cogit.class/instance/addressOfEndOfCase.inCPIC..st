in-line cacheing
addressOfEndOfCase: n inCPIC: cPIC 
	"calculate the end of the n'th case statement - which is complicated because we have case 1 right at the top of our CPIC and then build up from the last one. Yes I know this sounds strange, but trust me - I'm an Engineer, we do things backwards all the emit"

	<var: #cPIC type: #'CogMethod *'>
	self assert: (n >= 1and: [n <= MaxCPICCases]).
	^n = 1
		ifTrue: [cPIC asInteger + firstCPICCaseOffset]
		ifFalse: [cPIC asInteger + firstCPICCaseOffset + (MaxCPICCases + 1 - n * cPICCaseSize)]