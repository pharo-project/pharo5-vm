type inference
inferReturnTypeIn: aCodeGen
	"Attempt to infer the return type of the receiver and answer if it changed."

	| existingReturnType |
	existingReturnType := returnType.
	self inferReturnTypeFromReturnsIn: aCodeGen.

	"If the return type is now void, replace any and all ^expr with expr. ^self"
	(existingReturnType ~= returnType and: [returnType = #void]) ifTrue:
		[self transformVoidReturns].

	^existingReturnType ~= returnType