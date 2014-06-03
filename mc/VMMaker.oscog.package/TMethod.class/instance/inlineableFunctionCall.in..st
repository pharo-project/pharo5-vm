inlining
inlineableFunctionCall: aNode in: aCodeGen
	"Answer true if the given send node is a call to a 'functional' method--a method whose body is a single return statement of some expression and whose actual parameters can all be directly substituted."

	self maybeBreakFor: aNode in: aCodeGen.
	^aNode isSend
	  and: [(aCodeGen methodNamed: aNode selector)
			ifNil:
				[aNode asTransformedConstantPerform
					ifNil: [false]
					ifNotNil: [:n| self inlineableFunctionCall: n in: aCodeGen]]
			ifNotNil:
				[:m|
				 m ~~ self
				 and: [m isFunctional
				 and: [(aCodeGen mayInline: m selector)
				 and: [aNode args allSatisfy: [ :a | self isSubstitutableNode: a intoMethod: m in: aCodeGen]]]]]]