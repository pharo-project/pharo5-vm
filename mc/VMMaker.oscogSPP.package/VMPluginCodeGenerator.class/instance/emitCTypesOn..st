C code generator
emitCTypesOn: aStream
	"Store local type declarations on the given stream."
	(self structClassesForTranslationClasses: { pluginClass }) do:
		[:structClass|
		(structClass isAbstract not
		 and: [pluginClass shouldGenerateTypedefFor: structClass]) ifTrue:
			[structClass printTypedefOn: aStream.
			 aStream cr; cr]]