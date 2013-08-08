garbage collection
markYoungObjects: annotation pc: mcpc method: cogMethod
	"Mark and trace young literals."
	<var: #mcpc type: #'char *'>
	| literal cacheTag |
	annotation = IsObjectReference ifTrue:
		[literal := backEnd literalBeforeFollowingAddress: mcpc asInteger.
		 objectRepresentation markAndTraceLiteralIfYoung: literal].
	(self isSendAnnotation: annotation) ifTrue:
		[cacheTag := backEnd inlineCacheTagAt: mcpc asInteger.
		 objectRepresentation markAndTraceLiteralIfYoung: cacheTag].
	^0 "keep scanning"