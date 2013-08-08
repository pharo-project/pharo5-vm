garbage collection
mapObjectReferencesInClosedPIC: cPIC
	"Remap all object references in the closed PIC.  Answer if any references are young.
	Set codeModified if any modifications are made."
	<var: #cPIC type: #'CogMethod *'>
	| pc refersToYoung |
	pc := cPIC asInteger + firstCPICCaseOffset.
	refersToYoung := self updateMaybeObjRefAt: pc - backEnd jumpLongByteSize.
	pc := pc + cPICCaseSize.
	2 to: cPIC cPICNumCases do:
		[:i|
		(self updateMaybeObjRefAt: pc - backEnd jumpLongConditionalByteSize - backEnd loadLiteralByteSize) ifTrue:
			[refersToYoung := true].
		(self updateMaybeObjRefAt: pc - backEnd jumpLongConditionalByteSize) ifTrue:
			[refersToYoung := true].
		pc := pc + cPICCaseSize].
	^refersToYoung