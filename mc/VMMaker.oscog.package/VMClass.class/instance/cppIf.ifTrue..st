translation support
cppIf: conditionBlockOrValue ifTrue: trueExpressionOrBlock
	"When translated, produces #if (condition) #else #endif CPP directives.
	 Example usage:

		self cppIf: IMMUTABILITY
			ifTrue: [(self internalIsImmutable: obj) ifTrue:
						[^self primitiveFailFor: PrimErrNoModification]]"
	<doNotGenerate>
	^self cppIf: conditionBlockOrValue ifTrue: trueExpressionOrBlock ifFalse: nil