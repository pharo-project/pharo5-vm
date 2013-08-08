inlining
inlineableFunctionCall: aNode in: aCodeGen
	"Answer true if the given send node is a call to a 'functional' method--a method whose body is a single return statement of some expression and whose actual parameters can all be directly substituted."

	| m |
	self maybeBreakFor: aNode in: aCodeGen.
	^aNode isSend
	and: [(m := aCodeGen methodNamed: aNode selector) notNil  "nil if builtin or external function"
	and: [m isFunctional
	and: [(aCodeGen mayInline: m selector)
	and: [aNode args allSatisfy: [ :a | self isSubstitutableNode: a intoMethod: m in: aCodeGen]]]]]