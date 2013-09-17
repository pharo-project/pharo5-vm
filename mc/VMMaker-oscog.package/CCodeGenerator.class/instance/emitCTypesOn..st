C code generator
emitCTypesOn: aStream 
	"Store local type declarations on the given stream."
	vmClass ifNotNil:
		[(self structClassesForTranslationClasses: { vmClass }) do:
			[:structClass|
			(structClass isAbstract not
			 and: [vmClass shouldGenerateTypedefFor: structClass]) ifTrue:
				[structClass printTypedefOn: aStream.
				 aStream cr; cr]]]