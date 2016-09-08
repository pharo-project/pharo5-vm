inlining
inlineableFunctionCall: aNode in: aCodeGen
	"Answer true if the given send node is a call to a 'functional' method--a method whose body is a single return statement of some expression and whose actual parameters can all be directly substituted."

	aCodeGen maybeBreakForTestToInline: aNode in: self.
	aNode isSend ifFalse:
		[^false].
	^(aCodeGen methodNamed: aNode selector)
		ifNil:
			[aNode asTransformedConstantPerform
				ifNil: [self isInlineableConditional: aNode in: aCodeGen]
				ifNotNil: [:n| self inlineableFunctionCall: n in: aCodeGen]]
		ifNotNil:
			[:m|
			 m ~~ self
			 and: [m isFunctional
			 and: [(aCodeGen mayInline: m selector)
			 and: [aNode args allSatisfy: [ :a | self isSubstitutableNode: a intoMethod: m in: aCodeGen]]]]]