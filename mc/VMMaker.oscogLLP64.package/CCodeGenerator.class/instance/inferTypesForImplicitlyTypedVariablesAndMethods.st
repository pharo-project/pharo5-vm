type inference
inferTypesForImplicitlyTypedVariablesAndMethods
	"Infer the return tupe and the types of untyped variables.
	 As far as variables go, for now we try only to infer variables
	 assigned the result of #longLongAt:, but much more could be
	 done here."

	"Iterate over all methods, inferring #void return types, until we reach a fixed point."
	| allMethods |
	allMethods := apiMethods
					ifNil: [methods]
					ifNotNil: [(Set withAll: methods)
								addAll: apiMethods;
								yourself].
	"Make an initial pass to assign the return types of all simple methods that return constants,
	 or those that have explicit return types."						
	allMethods do:
		[:m|
		m removeFinalSelfReturnIn: self. "must precede recordDeclarationsIn: because it may set returnType"
		m recordDeclarationsIn: self.
		(m returnType isNil
		 and: [m isReturnConstant]) ifTrue:
			[m inferReturnTypeIn: self]].

	"now iterate until we reach a fixed point"
	[| changedReturnType |
	 changedReturnType := false.
	 allMethods do:
		[:m|
		 m inferTypesForImplicitlyTypedVariablesIn: self.
		 (m inferReturnTypeIn: self) ifTrue:
			[changedReturnType := true]].
	 changedReturnType] whileTrue.

	"Type all as-yet-untyped methods as the default"
	methods do:
		[:m|
		m returnType ifNil:
			[m returnType: (m returnsExpression
								ifTrue: [#sqInt]
								ifFalse: [self implicitReturnTypeFor: m])].
		m transformReturns].

	"Make a final pass to type anything assigned from the default type"
	allMethods do:
		[:m|
		 m inferTypesForImplicitlyTypedVariablesIn: self]