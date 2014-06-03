in-line cacheing
unlinkIfLinkedSend: annotation pc: mcpc to: theCogMethod
	<var: #mcpc type: #'char *'>
	| entryPoint |
	(self isSendAnnotation: annotation) ifTrue:
		[entryPoint := backEnd callTargetFromReturnAddress: mcpc asInteger.
		 entryPoint > methodZoneBase
			ifTrue: "It's a linked send."
				[self targetMethodAndSendTableFor: entryPoint into:
					[:targetMethod :sendTable| | unlinkedRoutine |
					 targetMethod asInteger = theCogMethod ifTrue:
						[unlinkedRoutine := sendTable at: (targetMethod cmNumArgs min: NumSendTrampolines - 1).
						 backEnd
							rewriteInlineCacheAt: mcpc asInteger
							tag: targetMethod selector
							target: unlinkedRoutine.
						 codeModified := true]]]
			ifFalse: "Can't tell the target with PushReciver/SendImplicit so flush anyway."
				[self cppIf: NewspeakVM ifTrue:
					[entryPoint = ceImplicitReceiverTrampoline ifTrue:
						[backEnd
							unalignedLongAt: mcpc asInteger + backEnd jumpShortByteSize put: 0;
							unalignedLongAt: mcpc asInteger + backEnd jumpShortByteSize + BytesPerOop put: 0]]]].
	^0 "keep scanning"