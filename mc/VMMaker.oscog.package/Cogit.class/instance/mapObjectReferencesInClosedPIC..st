garbage collection
mapObjectReferencesInClosedPIC: cPIC
	"Remap all object references in the closed PIC.  Answer if any references are young.
	Set codeModified if any modifications are made."
	<var: #cPIC type: #'CogMethod *'>
	| pc refersToYoung |
	pc := self addressOfEndOfCase:1 inCPIC:cPIC.

	"first we check the obj ref at the beginning of the CPIC"
	refersToYoung := self updateMaybeObjRefInClosedPICAt: pc - backEnd jumpLongByteSize.

	"We find the end address of the cPICNumCases'th case and can then just step forward by the case size thereafter"
	pc := self addressOfEndOfCase: cPIC cPICNumCases inCPIC: cPIC.
	
	"For each case we check any object reference at the end address - sizeof(conditional instruction) and then increment the end address by case size"
	2 to: cPIC cPICNumCases do:
		[:i|
		objectRepresentation inlineCacheTagsMayBeObjects ifTrue:
			[(self updateMaybeClassRefInClosedPICAt: pc - backEnd jumpLongConditionalByteSize) ifTrue:
				[refersToYoung := true]].
		(self updateMaybeObjRefInClosedPICAt: pc - backEnd jumpLongConditionalByteSize) ifTrue:
			[refersToYoung := true].
		pc := pc + cPICCaseSize].
	^refersToYoung