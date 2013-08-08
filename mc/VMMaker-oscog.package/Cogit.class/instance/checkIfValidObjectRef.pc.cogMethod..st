garbage collection
checkIfValidObjectRef: annotation pc: mcpc cogMethod: cogMethod
	<var: #mcpc type: #'char *'>
	annotation = IsObjectReference ifTrue:
		[| literal |
		 literal := backEnd literalBeforeFollowingAddress: mcpc asInteger.
		 (objectRepresentation checkValidObjectReference: literal) ifFalse:
			[self print: 'object ref leak in CM '; printHex: cogMethod asInteger; print: ' @ '; printHex: mcpc asInteger; cr.
			^1]].
	(self isSendAnnotation: annotation) ifTrue:
		[| cacheTag |
		 cacheTag := backEnd inlineCacheTagAt: mcpc asInteger.
		 (objectRepresentation checkValidInlineCacheTag: cacheTag) ifFalse:
			[self print: 'cache tag/selector leak in CM '; printHex: cogMethod asInteger; print: ' @ '; printHex: mcpc asInteger; cr.
			^1]].
	^0 "keep scanning"