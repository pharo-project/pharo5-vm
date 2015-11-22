garbage collection
followMethodReferencesInClosedPIC: cPIC
	"Remap all object references in the closed PIC.  Answer if any references are young.
	Set codeModified if any modifications are made."
	<var: #cPIC type: #'CogMethod *'>
	| pc refersToYoung |
	pc := self addressOfEndOfCase: 1 inCPIC: cPIC.

	"first we check the potential method oop load at the beginning of the CPIC"
	refersToYoung := self followMaybeObjRefInClosedPICAt: pc - backEnd jumpLongByteSize.

	"We find the end address of the cPICNumCases'th case and can then just step forward by the case size thereafter"
	pc := self addressOfEndOfCase:  cPIC cPICNumCases inCPIC: cPIC.
	
	"Next we check the potential potential method oop load for each case."
	2 to: cPIC cPICNumCases do:
		[:i|
		(self followMaybeObjRefInClosedPICAt: pc - backEnd jumpLongConditionalByteSize - backEnd cmpC32RTempByteSize) ifTrue:
			[refersToYoung := true].
		pc := pc + cPICCaseSize].
	^refersToYoung