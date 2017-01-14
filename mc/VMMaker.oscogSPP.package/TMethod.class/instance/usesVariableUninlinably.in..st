inlining
usesVariableUninlinably: argName in: aCodeGen
	^parseTree anySatisfy:
		[:node|
		node isSend
		and: [(aCodeGen isAssertSelector: node selector)
		and: [node args anySatisfy:
				[:argNode|
				 argNode anySatisfy:
					[:subNode|
					 subNode isVariable and: [subNode name = argName]]]]]]