garbage collection
followMethodReferencesInClosedPIC: cPIC
	"Remap all object references in the closed PIC.  Answer if any references are young.
	Set codeModified if any modifications are made."
	<var: #cPIC type: #'CogMethod *'>
	| pc refersToYoung |
	pc := self addressOfEndOfCase: 1 inCPIC: cPIC.

	"first we check the method obj ref at the beginning of the CPIC"
	refersToYoung := self followMaybeObjRefInClosedPICAt: pc - backEnd jumpLongByteSize.

	"We find the end address of the cPICNumCases'th case and can then just step forward by the case size thereafter"
	pc := self addressOfEndOfCase:  cPIC cPICNumCases inCPIC: cPIC.
	
	"For each case we check any object reference at the end address - sizeof(conditional instruction) and then increment the end address by case size"
	2 to: cPIC cPICNumCases do:
		[:i|
		(self followMaybeObjRefInClosedPICAt: pc - backEnd jumpLongConditionalByteSize) ifTrue:
			[refersToYoung := true].
		pc := pc + cPICCaseSize].
	^refersToYoung