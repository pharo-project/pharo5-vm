garbage collection
checkValidObjectReferencesInClosedPIC: cPIC
	<var: #cPIC type: #'CogMethod *'>
	| ok pc |
	ok := true.
	pc := cPIC asInteger + firstCPICCaseOffset.
	
	"first we check the obj ref at the beginning of the CPIC"
	(self checkMaybeObjRefInClosedPIC: (backEnd literalBeforeFollowingAddress: pc - backEnd jumpLongByteSize)) ifFalse:
		[self print: 'object leak in CPIC '; printHex: cPIC asInteger;
			print: ' @ '; printHex: pc - backEnd jumpLongByteSize; cr.
		 ok := false].
	
	"Next we step over each case that is in use. We find the end address of the cPICNumCases'th case and can then just step forward by the case size thereafter"
	pc := self addressOfEndOfCase: cPIC cPICNumCases inCPIC: cPIC.
	
	"For each case we check any object reference at the end address - sizeof(conditional instruction) and then increment the end address by case size"
	2 to: cPIC cPICNumCases do:
		[:i|
		(self inlineCacheTagsAreIndexes not
		 and: [objectRepresentation inlineCacheTagsMayBeObjects]) ifTrue:
			[(self checkMaybeObjRefInClosedPIC: (backEnd literal32BeforeFollowingAddress: pc - backEnd jumpLongConditionalByteSize)) ifFalse:
				[self print: 'object leak in CPIC '; printHex: cPIC asInteger;
					print: ' @ '; printHex: pc - backEnd jumpLongConditionalByteSize - backEnd loadLiteralByteSize; cr.
				 ok := false]].
		(self checkMaybeObjRefInClosedPIC: (backEnd literalBeforeFollowingAddress: pc - backEnd jumpLongConditionalByteSize - backEnd cmpC32RTempByteSize)) ifFalse:
			[self print: 'object leak in CPIC '; printHex: cPIC asInteger;
				print: ' @ '; printHex: pc - backEnd jumpLongConditionalByteSize; cr.
			 ok := false].
		pc := pc + cPICCaseSize].
	^ok