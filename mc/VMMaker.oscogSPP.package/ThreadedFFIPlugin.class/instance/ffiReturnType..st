symbol loading
ffiReturnType: specOnStack
	"Answer the return type object for the current invocation"
	| specLiteral argTypes |
	specLiteral := specOnStack
					ifTrue: [interpreterProxy stackValue: 1]
					ifFalse: [interpreterProxy literal: 0 ofMethod: interpreterProxy primitiveMethod].
	argTypes := interpreterProxy fetchPointer: ExternalFunctionArgTypesIndex ofObject: specLiteral.
	^interpreterProxy fetchPointer: 0 ofObject: argTypes