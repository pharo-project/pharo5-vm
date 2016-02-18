C code generator
preDeclareExternFunction: tMethod on: aStream
	self withOptionalVerbiageFor: tMethod selector
		on: aStream
		do: [aStream cr.
			tMethod static: false; export: false; emitCFunctionPrototype: aStream generator: self.
			aStream nextPut: $;]
		ifOptionalDo:
			[aStream cr; nextPutAll: '# define '.
			 (TSendNode new
				setSelector: tMethod selector
					receiver: (TVariableNode new setName: 'interpreterProxy')
						arguments: (tMethod args collect: [:a| TVariableNode new setName: a]))
				emitCCodeAsArgumentOn: aStream
					level: 0
						generator: self.
			 aStream nextPutAll: ' 0']	