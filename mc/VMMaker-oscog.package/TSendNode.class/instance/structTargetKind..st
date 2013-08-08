testing
structTargetKind: aCodeGen
	"Answer if the recever evaluates to a struct or struct pointer
	 and hence can be dereferenced using . or ->.  Answer any of
	 #struct #pointer or nil.  Right now we don't need or support
	 structure return so this method answers either #pointer or nil."
	selector == #cCoerceSimple:to: ifTrue:
		[^(VMStructType isTypePointerToStruct: arguments last value) ifTrue:
			[#pointer]].

	^(aCodeGen selectorReturnsPointerToStruct: selector) ifTrue:
		[#pointer]