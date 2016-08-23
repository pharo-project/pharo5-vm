type inference
inferReturnTypeIn: aCodeGen
	"Attempt to infer the return type of the receiver and answer if it changed."

	| existingReturnType |
	existingReturnType := returnType.
	self inferReturnTypeFromReturnsIn: aCodeGen.
	^existingReturnType ~= returnType