in-line cacheing
addressOfEndOfCase: n inCPIC: cPIC
	"N.B. zero-relative"
	<var: #cPIC type: #'CogMethod *'>
	^cPIC asInteger + firstCPICCaseOffset + (n * cPICCaseSize)