object enumeration
lastPointerOf: oop header: header recordWeakRoot: recordWeakRoot "<Boolean>"
	"Return the byte offset of the last pointer field of the given object.  
	 Works with CompiledMethods, as well as ordinary objects. 
	 Can be used even when the type bits are not correct.
	 This is a version of lastPointerOf: for markAndTrace:.
	 Already overridden to trace stack pages for the StackInterpreter.
	 Override to handle hidden pointer to CogMethod in a
	 CompiledMethod header field."
	| fmt sz contextSize methodHeader nonWeakCnt |
	<inline: true>
	<asmLabel: false>
	fmt := self formatOfHeader: header.
	fmt <= 4 ifTrue:
		[fmt >= 3 ifTrue:
			[fmt = 4 ifTrue:
				[recordWeakRoot ifTrue:
					["And remember as weak root"
					 weakRootCount := weakRootCount + 1.
					 self assert: weakRootCount <= WeakRootTableSize.
					 weakRoots at: weakRootCount put: oop].
				nonWeakCnt := self nonWeakFieldsOf: oop.

				 " we deal with ephemerons separately"
				(self isEphemeron: oop nonWeakFields: nonWeakCnt) 
					ifTrue: [ ^ self lastPointerOfEphemeron: oop nonWeakFields: nonWeakCnt ].

				"Do not trace the object's indexed fields if it's a weak class"
				^ nonWeakCnt  << ShiftForWord].
			"So fmt is 3"
			(self isContextHeader: header) ifTrue:
				[coInterpreter setTraceFlagOnContextsFramesPageIfNeeded: oop.
				 "contexts end at the stack pointer avoiding having to init fields beyond it"
				 contextSize := coInterpreter fetchStackPointerOf: oop.
				 self assert: ReceiverIndex + contextSize < (self lengthOf: oop baseHeader: header format: fmt).
				 ^CtxtTempFrameStart + contextSize * BytesPerWord]].
		 sz := self sizeBitsOfSafe: oop.
		 ^sz - BaseHeaderSize  "all pointers" ].
	fmt < 12 ifTrue: [^0]. "no pointers"

	"CompiledMethod: contains both pointers and bytes; may have an associated CogMethod"
	methodHeader := self longAt: oop + BaseHeaderSize.
	(coInterpreter isCogMethodReference: methodHeader) ifTrue:
		[self assert: (coInterpreter cCoerceSimple: methodHeader to: #'CogMethod *') cmType = CMMethod.
		 methodHeader := (coInterpreter cCoerceSimple: methodHeader to: #'CogMethod *') methodHeader].
	^(coInterpreter literalCountOfHeader: methodHeader) * BytesPerWord + BaseHeaderSize