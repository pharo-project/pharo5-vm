garbage collection
followMethodReferencesInClosedPIC: cPIC
	"Remap all object references in the closed PIC.  Answer if any references are young.
	Set codeModified if any modifications are made."
	<var: #cPIC type: #'CogMethod *'>
	| pc refersToYoung |
	pc := cPIC asInteger + firstCPICCaseOffset.
	refersToYoung := self followMaybeObjRefAt: pc - backEnd jumpLongByteSize.
	pc := pc + cPICCaseSize.
	2 to: cPIC cPICNumCases do:
		[:i|
		(self followMaybeObjRefAt: pc - backEnd jumpLongConditionalByteSize) ifTrue:
			[refersToYoung := true].
		pc := pc + cPICCaseSize].
	^refersToYoung