utilities
nilOrBooleanConditionFor: nodeOrNil
	"If nodeOrNil is one of the conditional sends for which we do translation-time dead code elimination
	 (i.e. cppIf:ifTrue: et al or ifTrue: et al) and the conditional does evaluate to a translation-time
	 boolean constant, answer that constant, otherwise answer nil.  Used to prune dead code,
	 either for code egenraton or dead variable elimination."
	nodeOrNil ifNil:
		[^nil].
	nodeOrNil isSend ifFalse:
		[^nil].
	(#(cppIf:ifTrue: cppIf:ifTrue:ifFalse:) includes: nodeOrNil selector) ifTrue:
		[^(optionsDictionary notNil
		   and: [nodeOrNil args first isConstant
		   and: [#(true false) includes: (optionsDictionary at: nodeOrNil args first name ifAbsent: [nil])]]) ifTrue:
			[optionsDictionary at: nodeOrNil args first name]].

	^(#(ifTrue: ifFalse: ifTrue:ifFalse: ifFalse:ifTrue:) includes: nodeOrNil selector) ifTrue:
		[self nilOrBooleanConstantReceiverOf: nodeOrNil]