munging
prototypeClassNameMetaSelectorMethodDo: quaternaryBlock
	prototypes ifNil:
		[prototypes := OrderedCollection new.
		SpurBootstrap new prototypeClassNameMetaSelectorMethodDo:
			[:className :isMeta :selector :method| 
			(#(BytecodeEncoder CompiledMethod EncoderForSqueakV4PlusClosures
				InstructionClient InstructionStream MethodNode) includes: className) ifTrue:
					[prototypes addLast: {className. isMeta. selector. method}]]].
	prototypes do: [:tuple| quaternaryBlock valueWithArguments: tuple]