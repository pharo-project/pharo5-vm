garbage collection
checkValidObjectReferencesInClosedPIC: cPIC
	<var: #cPIC type: #'CogMethod *'>
	| ok pc |
	ok := true.
	pc := cPIC asInteger + firstCPICCaseOffset.
	(self checkMaybeObjRefAt: pc - backEnd jumpLongByteSize) ifFalse:
		[self print: 'object leak in CPIC '; printHex: cPIC asInteger;
			print: ' @ '; printHex: pc - backEnd jumpLongByteSize; cr.
		 ok := false].
	pc := pc + cPICCaseSize.
	2 to: cPIC cPICNumCases do:
		[:i|
		objectRepresentation inlineCacheTagsMayBeObjects ifTrue:
			[(self checkMaybeObjRefAt: pc - backEnd jumpLongConditionalByteSize - backEnd loadLiteralByteSize) ifFalse:
				[self print: 'object leak in CPIC '; printHex: cPIC asInteger;
					print: ' @ '; printHex: pc - backEnd jumpLongConditionalByteSize - backEnd loadLiteralByteSize; cr.
				 ok := false]].
		(self checkMaybeObjRefAt: pc - backEnd jumpLongConditionalByteSize) ifFalse:
			[self print: 'object leak in CPIC '; printHex: cPIC asInteger;
				print: ' @ '; printHex: pc - backEnd jumpLongConditionalByteSize; cr.
			 ok := false].
		pc := pc + cPICCaseSize].
	^ok