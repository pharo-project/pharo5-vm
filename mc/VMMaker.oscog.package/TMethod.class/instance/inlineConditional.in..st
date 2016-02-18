inlining
inlineConditional: aSendNode in: aCodeGen
	"If possible answer the inlining of a conditional, otherwise answer nil.
	 Currently the only pattern we support is
		aSend ifTrue:/ifFalse: [...]
	 where aSend is marked inline and always answers booleans."
	self assert: (self isInlineableConditional: aSendNode in: aCodeGen).
	self assert: aSendNode args first isStmtList.
	^(aSendNode args first statements size = 1
	  and: [aSendNode args first statements first isReturn])
		ifTrue: [self inlineReturningConditional: aSendNode in: aCodeGen]
		ifFalse: [self inlineGuardingConditional: aSendNode in: aCodeGen]