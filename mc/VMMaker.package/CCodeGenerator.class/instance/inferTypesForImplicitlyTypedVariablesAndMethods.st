type inference
inferTypesForImplicitlyTypedVariablesAndMethods
	"Infer the return tupe and the types of untyped variables.
	 As far as variables go, for now we try only to infer variables
	 assigned the result of #longLongAt:, but much more could be
	 done here."

	"Iterate over all methods, inferring #void return types, until we reach a fixed point."
	| firstTime allMethods |
	firstTime := true.
	allMethods := apiMethods
					ifNil: [methods]
					ifNotNil: [(Set withAll: methods)
								addAll: apiMethods;
								yourself].
	[| changedReturnType |
	 changedReturnType := false.
	 allMethods do:
		[:m|
		 firstTime ifTrue:
			[m removeFinalSelfReturnIn: self. "must preceed recordDeclarationsIn: because it may set returnType"
			 m recordDeclarationsIn: self].
		 m inferTypesForImplicitlyTypedVariablesIn: self.
		 (m inferReturnTypeIn: self) ifTrue:
			[changedReturnType := true]].
	 firstTime := false.
	 changedReturnType] whileTrue.

	"Type all as-yet-untyped methods as the default"
	methods do:
		[:m|
		m returnType ifNil:
			[m returnType: (self implicitReturnTypeFor: m selector)]]