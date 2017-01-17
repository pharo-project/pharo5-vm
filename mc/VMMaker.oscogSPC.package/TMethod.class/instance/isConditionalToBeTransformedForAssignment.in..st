inlining
isConditionalToBeTransformedForAssignment: aSend in: aCodeGen
	"Answer if a send is of the form
		e1
			ifTrue: [e2 ifTrue: [self m1] ifFalse: [self m2]]
			ifFalse: [self m3]
	 such that at least one of the sends mN may be inlined.."

	^(#(ifTrue:ifFalse: ifFalse:ifTrue:) includes: aSend selector)
	   and: [aSend args anySatisfy:
			[:arg| | stmt |
			self assert: arg isStmtList.
			arg statements size > 1
			or: [(stmt := arg statements first) isSwitch
			or: [stmt isSend
				and: [(aCodeGen mayInline: stmt selector)
					or: [self isConditionalToBeTransformedForAssignment: stmt in: aCodeGen]]]]]]