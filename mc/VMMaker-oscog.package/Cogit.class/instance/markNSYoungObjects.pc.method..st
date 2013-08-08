garbage collection
markNSYoungObjects: annotation pc: mcpc method: cogMethod
	<option: #NewspeakVM>
	"Mark and trace young literals."
	<var: #mcpc type: #'char *'>
	| literal cacheTag entryPoint |
	annotation = IsObjectReference ifTrue:
		[literal := backEnd literalBeforeFollowingAddress: mcpc asInteger.
		 objectRepresentation markAndTraceLiteralIfYoung: literal].
	(self isSendAnnotation: annotation) ifTrue:
		[cacheTag := backEnd inlineCacheTagAt: mcpc asInteger.
		 objectRepresentation markAndTraceLiteralIfYoung: cacheTag.
		 entryPoint := backEnd callTargetFromReturnAddress: mcpc asInteger.
		 entryPoint = ceImplicitReceiverTrampoline ifTrue:
			[| class mixin |
			 (class := backEnd unalignedLongAt: mcpc asInteger + backEnd jumpShortByteSize) ~= 0 ifTrue:
				[objectRepresentation markAndTraceLiteralIfYoung: class.
				 mixin := backEnd unalignedLongAt: mcpc asInteger + backEnd jumpShortByteSize + BytesPerOop.
				 objectRepresentation markAndTraceLiteralIfYoung: mixin]]].
	^0 "keep scanning"