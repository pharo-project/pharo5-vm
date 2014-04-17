C code generator
emitCTypesOn: aStream 
	"Store local type declarations on the given stream."
	([pluginClass ancilliaryStructClasses]
		on: MessageNotUnderstood
		do: [:ex| ex message selector == #ancilliaryStructClasses ifTrue: [^self].
				ex pass]) do:
			[:structClass|
			(pluginClass shouldGenerateTypedefFor: structClass) ifTrue:
				[structClass printTypedefOn: aStream.
				 aStream cr; cr]]