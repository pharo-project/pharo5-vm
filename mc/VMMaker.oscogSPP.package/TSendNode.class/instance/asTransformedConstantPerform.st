inlining support
asTransformedConstantPerform
	"If the receiver is a send of perform: with a constant selector,
	 answer a send node that elides the perform:, otherwise answer nil."
	^(selector isSymbol
	  and: [(selector beginsWith: #perform:)
	  and: [(selector keywords allSatisfy: [:kw| #('perform:' 'with:') includes: kw])
	  and: [arguments first isConstant
	  and: [arguments first value isSymbol
	  and: [arguments first value numArgs + 1 = arguments size]]]]]) ifTrue:
		[TSendNode new
			setSelector: arguments first value
			receiver: receiver
			arguments: arguments allButFirst]