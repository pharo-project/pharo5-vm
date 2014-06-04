in-line cacheing
unlinkIfFreeOrLinkedSend: annotation pc: mcpc of: theSelector
	<var: #mcpc type: #'char *'>
	| entryPoint |
	(self isSendAnnotation: annotation) ifTrue:
		[entryPoint := backEnd callTargetFromReturnAddress: mcpc asInteger.
		 entryPoint > methodZoneBase
			ifTrue: "It's a linked send."
				[self targetMethodAndSendTableFor: entryPoint into:
					[:targetMethod :sendTable| | unlinkedRoutine |
					 (targetMethod cmType = CMFree
					  or: [targetMethod selector = theSelector]) ifTrue:
						[unlinkedRoutine := sendTable at: (targetMethod cmNumArgs min: NumSendTrampolines - 1).
						 backEnd
							rewriteInlineCacheAt: mcpc asInteger
							tag: targetMethod selector
							target: unlinkedRoutine.
						 codeModified := true]]]
			ifFalse:
				[self cppIf: NewspeakVM ifTrue:
					[(entryPoint = ceImplicitReceiverTrampoline
					 and: [(backEnd inlineCacheTagAt: mcpc asInteger) = theSelector]) ifTrue:
					 	[backEnd
							unalignedLongAt: mcpc asInteger + backEnd jumpShortByteSize put: 0;
							unalignedLongAt: mcpc asInteger + backEnd jumpShortByteSize + BytesPerOop put: 0]]]].
	^0 "keep scanning"