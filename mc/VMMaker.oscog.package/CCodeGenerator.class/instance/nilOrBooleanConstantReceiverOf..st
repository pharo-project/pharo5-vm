utilities
nilOrBooleanConstantReceiverOf: aNode
	"Answer nil or the boolean constant that is the receiver of the given message send.
	 Used to suppress conditional code when the condition is a translation-time constant."

	| val receiver argument |
	generateDeadCode ifTrue:[^nil].
	((self isConstantNode: aNode valueInto: [:v| val := v])
	 and: [#(true false) includes: val]) ifTrue:
		[^val].
	aNode isSend ifTrue:
		[((#(or: and:) includes: aNode selector)
		 and: [aNode args last isStmtList
		 and: [aNode args last statements size = 1]]) ifTrue:
			[(self nilOrBooleanConstantReceiverOf: aNode receiver) ifNotNil:
				[:rcvr|
				((rcvr == false and: [aNode selector == #and:])
				 or: [rcvr == true and: [aNode selector == #or:]]) ifTrue:
					[^rcvr].
				(self nilOrBooleanConstantReceiverOf: aNode args last statements first) ifNotNil:
					[:arg|
					^rcvr perform: aNode selector with: [arg]]]].
		 ((#(= ~= < > <= >=) includes: aNode selector)
		  and: [(self isConstantNode: aNode receiver valueInto: [:v| receiver := v])
		  and: [receiver isInteger
		  and: [(self isConstantNode: aNode args first valueInto: [:v| argument := v])
		  and: [argument isInteger]]]]) ifTrue:
			[^receiver perform: aNode selector with: argument]].
	^nil