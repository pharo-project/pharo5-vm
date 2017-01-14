utilities
nilOrBooleanConstantReceiverOf: aNode
	"Answer nil or the boolean constant that is the receiver of the given message send.
	 Used to suppress conditional code when the condition is a translation-time constant."

	| val receiver argument arms |
	generateDeadCode ifTrue:[^nil].
	((self isConstantNode: aNode valueInto: [:v| val := v])
	 and: [#(true false) includes: val]) ifTrue:
		[^val].
	aNode isSend ifTrue:
		[aNode selector == #not ifTrue:
			[(self nilOrBooleanConstantReceiverOf: aNode receiver) ifNotNil:
				[:bool| ^bool not]].
		 ((#(isNil notNil) includes: aNode selector)
		  and: [self isNilConstantReceiverOf: aNode]) ifTrue:
			[^aNode selector == #isNil].
		 ((#(or: and:) includes: aNode selector)
		 and: [aNode args last isStmtList
		 and: [aNode args last statements size = 1]]) ifTrue:
			[(self nilOrBooleanConstantReceiverOf: aNode receiver) ifNotNil:
				[:rcvr|
				((rcvr == false and: [aNode selector == #and:])
				 or: [rcvr == true and: [aNode selector == #or:]]) ifTrue:
					[^rcvr].
				(self nilOrBooleanConstantReceiverOf: aNode args last statements first) ifNotNil:
					[:arg|
					^rcvr perform: aNode selector with: [arg]]].
			 "We can also eliminate expr and: [false], but only if expr is side-effect free.
			  This is a weak test; we don't traverse calls.  Caveat emptor!"
			 (aNode selector == #and:
			  and: [(aNode receiver noneSatisfy: [:node| node isAssignment]) "No side-effects in the elided expression"
			  and: [aNode args last statements size = 1]]) ifTrue:
				[(self nilOrBooleanConstantReceiverOf: aNode args last statements first) ifNotNil:
					[:arg|
					arg ifFalse:
						[^arg]]]].
		"Look for Const ifTrue: [self foo] ifFalse: [false] => false"
		 ((#(ifTrue:ifFalse: ifFalse:ifTrue:) includes: aNode selector)
		  and: [(self isConstantNode: aNode receiver valueInto: [:v| val := v])
		  and: [(#(true false) includes: val)
		  and: [arms := aNode args collect:
							[:altBlock| | bval |
							 (altBlock statements size = 1
							 and: [(self isConstantNode: altBlock statements last valueInto: [:v| bval := v])
							 and: [#(true false) includes: bval]]) ifTrue:
								[bval]].
				arms asArray ~= #(nil nil)]]]) ifTrue:
			[| arm |
			 arm := aNode selector == #ifTrue:ifFalse: == val
						ifTrue: [arms first]
						ifFalse: [arms last].
			 (#(true false) includes: arm) ifTrue:
				[^arm]].
		 ((#(= ~= < > <= >=) includes: aNode selector)
		  and: [(self isConstantNode: aNode receiver valueInto: [:v| receiver := v])
		  and: [receiver isInteger
		  and: [(self isConstantNode: aNode args first valueInto: [:v| argument := v])
		  and: [argument isInteger]]]]) ifTrue:
			[^receiver perform: aNode selector with: argument].
		 "Inlining for e.g. CharacterTable ifNil: [...] ifNotNil: [...]], which compiles to CharacterTable == nil ifTrue: [...] ifFalse: [...]"
		(aNode selector == #==
		 and: [aNode args first isVariable
		 and: [aNode args first name = 'nil'
		 and: [aNode receiver isConstant
		 and: [aNode receiver value == nil]]]]) ifTrue:
			[^true]].
	^nil