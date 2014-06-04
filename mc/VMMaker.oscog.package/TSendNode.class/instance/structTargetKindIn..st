testing
structTargetKindIn: aCodeGen
	"Answer if the recever evaluates to a struct or struct pointer
	 and hence can be dereferenced using . or ->.  Answer any of
	 #struct #pointer or nil.  Right now we don't need or support
	 structure return so this method answers either #pointer or nil."
	selector == #cCoerceSimple:to: ifTrue:
		[^(VMStructType isTypePointerToStruct: arguments last value) ifTrue:
			[#pointer]].

	selector == #addressOf: ifTrue:
		[^#pointer].

	selector == #at: ifTrue:
		[receiver isVariable ifTrue:
			[(aCodeGen typeOfVariable: receiver name) ifNotNil:
				[:type| | derefType |
				 type last = $* ifFalse:
					[^receiver structTargetKindIn: aCodeGen].
				 (VMStructType isTypeStruct: (aCodeGen
											extractTypeFor: receiver name
											fromDeclaration: type allButLast)) ifTrue:
						[^#struct]]].
		(receiver structTargetKindIn: aCodeGen) ifNotNil:
			[:kind| ^kind]].

	(aCodeGen selectorReturnsPointerToStruct: selector) ifTrue:
		[^#pointer].

	(aCodeGen selectorReturnsStruct: selector) ifTrue:
		[^#struct].

	^nil