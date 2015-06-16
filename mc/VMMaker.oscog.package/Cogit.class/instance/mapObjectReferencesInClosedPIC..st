garbage collection
mapObjectReferencesInClosedPIC: cPIC
	"Remap all object references in the closed PIC.  Answer if any references are young.
	Set codeModified if any modifications are made."
	<var: #cPIC type: #'CogMethod *'>
	| pc refersToYoung |
	pc := cPIC asInteger + firstCPICCaseOffset.
	refersToYoung := self updateMaybeObjRefInClosedPICAt: pc - backEnd jumpLongByteSize.
	pc := pc + cPICCaseSize.
	2 to: cPIC cPICNumCases do:
		[:i|
		objectRepresentation inlineCacheTagsMayBeObjects ifTrue:
			[(self updateMaybeClassRefAt: pc - backEnd jumpLongConditionalByteSize) ifTrue:
				[refersToYoung := true]].
		(self updateMaybeObjRefInClosedPICAt: pc - backEnd jumpLongConditionalByteSize) ifTrue:
			[refersToYoung := true].
		pc := pc + cPICCaseSize].
	^refersToYoung