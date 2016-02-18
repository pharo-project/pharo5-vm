transformations
ensureToByDoLoopLimitIsSafeAndEfficient: node in: aCodeGen
	"For both safety and efficiency, make sure that to:[by:]do: loops
	 with complex limits have a variable to hold the limit expression.
	 In C the limit expression is evaluated each time round the loop
	 so if the loop has side-effects (which it usually will), the C compiler
	 may not be able to optimize the limit expression itself."
	| limitExpr hasSideEffects |
	 limitExpr := node args first.
	 hasSideEffects := limitExpr anySatisfy:
						[:subNode|
						subNode isSend
						and: [(aCodeGen isBuiltinSelector: subNode selector) not
						and: [(subNode isStructSendIn: aCodeGen) not]]].
	 node args size = 4
		ifTrue:
			[hasSideEffects
				ifTrue: [locals add: node args last name]
				ifFalse: [node arguments: node args allButLast]]
		ifFalse: "If the expression is complex but as yet there is no limit variable, add it"
			[hasSideEffects ifTrue:
				[| var |
				 var := self unusedNamePrefixedBy: 'toDoLimit' avoiding: locals. "N.B. adds it to locals!!"
				 node arguments: node args, {TVariableNode new setName: var; yourself}.
				 declarations
					at: node args third args first
					ifPresent: [:decl| self declarationAt: var put: (self typeFor: node args third args first in: aCodeGen), ' ', var]]]