C code generation
shouldExcludeReceiverAsFirstArgument: aCodeGen
	"Only include the receiver as the first argument in certain cases.
	 The receiver is always included if it is an expression.
	 If it is a variable:
		 If the vmClass says it is an implicit variable, don't include it.
		 If the method's definingClass says it is an implicit variable, don't include it.
		 If the variable is 'self' and the method being called is not in
		 the method set (i.e. it is some external code), don't include it.
		 If it is a struct send of something the vm says is an implicit variable, don't include it."
	| m |
	(aCodeGen isAssertSelector: selector) ifTrue:
		[^true].

	(receiver isSend
	 and: [(receiver shouldExcludeReceiverAsFirstArgument: aCodeGen)
		or: [receiver receiver isVariable
			 and: [(self isSelfReference: receiver receiver in: aCodeGen)
				or: [self isStructReference: receiver receiver in: aCodeGen]]]]) ifTrue:
		[^aCodeGen isNonArgumentImplicitReceiverVariableName: receiver selector].

	^receiver isVariable
	    and: [(aCodeGen isNonArgumentImplicitReceiverVariableName: receiver name)
		    or: [(self isSelfReference: receiver in: aCodeGen)
			    and: [(m := aCodeGen methodNamed: selector) isNil
					or: [#(implicit nil) includes: m typeForSelf]]]]