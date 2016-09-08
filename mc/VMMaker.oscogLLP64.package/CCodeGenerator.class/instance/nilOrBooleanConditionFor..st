utilities
nilOrBooleanConditionFor: nodeOrNil
	"If nodeOrNil is one of the conditional sends for which we do translation-time dead code elimination
	 (i.e. cppIf:ifTrue: et al or ifTrue: et al) and the conditional does evaluate to a translation-time
	 boolean constant, answer that constant, otherwise answer nil.  Used to prune dead code,
	 either for code generaton or dead variable elimination."
	generateDeadCode ifTrue: [^nil].
	nodeOrNil ifNil:
		[^nil].
	nodeOrNil isSend ifFalse:
		[^nil].
	(#(ifTrue: ifFalse: ifTrue:ifFalse: ifFalse:ifTrue:) includes: nodeOrNil selector) ifTrue:
		[^self nilOrBooleanConstantReceiverOf: nodeOrNil receiver].
	(#(and: or:) includes: nodeOrNil selector) ifTrue:
		[^self nilOrBooleanConstantReceiverOf: nodeOrNil].
	(#(cppIf:ifTrue: cppIf:ifTrue:ifFalse:) includes: nodeOrNil selector) ifTrue:
		[(vmClass notNil
		 and: [nodeOrNil args first isConstant
		 and: [nodeOrNil args first value isSymbol
		 and: [((vmClass ifNil: [VMBasicConstants]) defineAtCompileTime: nodeOrNil args first value) not
		 and: [(vmClass bindingOf: nodeOrNil args first value) notNil]]]]) ifTrue:
			[self logger
					nextPutAll: 'Warning: cppIf: reference to ';
					store: nodeOrNil args first value;
					nextPutAll: ' when variable of same name exists.'; cr].

		 ^(optionsDictionary notNil
		   and: [nodeOrNil args first isConstant
		   and: [#(true false) includes: (optionsDictionary at: nodeOrNil args first name ifAbsent: [nil])]]) ifTrue:
			[optionsDictionary at: nodeOrNil args first name]].
	^nil