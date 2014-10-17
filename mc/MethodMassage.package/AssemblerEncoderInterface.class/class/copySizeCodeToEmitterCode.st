class initialization
copySizeCodeToEmitterCode
	"AssemblerEncoderInterface copySizeCodeToEmitterCode"
	BytecodeSizer selectorsAndMethodsDo:
		[:s :m| | emitterMethod |
		((m literals includes: #shouldBeImplemented) not
		and: [(emitterMethod := BytecodeEmitter compiledMethodAt: s) literals includes: #shouldBeImplemented]) ifTrue:
			[BytecodeEmitter
				compile:
					(m getSourceFromFile asString
						copyReplaceAll: 'encoder size'
						with: 'encoder gen')
					classified: #assembly]]