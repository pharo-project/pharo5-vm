inlining
isInlineableConditional: aSendNode in: aCodeGen
	"Answer if the given send node is of the form aSend [ifTrue:|ifFalse:] [statements]
	 where the method for aSend is marked as inline and all returns within it answer booleans."
	|method |
	^(#(ifTrue: ifFalse:) includes: aSendNode selector)
	  and: [aSendNode receiver isSend
	  and: [(method := aCodeGen anyMethodNamed: aSendNode receiver selector) notNil
	  and: [method inline == true
	  and: [method parseTree statements last isReturn
	  and: [method parseTree allSatisfy:
			[:node|
			 node isReturn not
			 or: [node expression isConstant
				 and: [#(true false) includes: node expression value]]]]]]]]