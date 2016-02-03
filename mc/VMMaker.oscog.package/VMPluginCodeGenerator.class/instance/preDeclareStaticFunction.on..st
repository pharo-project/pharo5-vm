C code generator
preDeclareStaticFunction: tMethod on: aStream
	| functionName |
	functionName := self cFunctionNameFor: tMethod selector.
	self withOptionalVerbiageFor: tMethod selector
		on: aStream
		do: 
			[aStream cr; nextPutAll:
				((String streamContents: 
					[:s|
						tMethod
							static: true;
							emitCFunctionPrototype: s generator: self])
					copyReplaceAll: functionName
					with: '(*', functionName, ')'
					tokenish: [:ch| ch = $_ or: [ch isAlphaNumeric]]).
			aStream nextPut: $;]
		ifOptionalDo: [aStream cr; nextPutAll: '# define '.
			 (TSendNode new
				setSelector: tMethod selector
					receiver: (TVariableNode new setName: 'interpreterProxy')
						arguments: (tMethod args collect: [:a| TVariableNode new setName: a]))
				emitCCodeAsArgumentOn: aStream
					level: 0
						generator: self.
			 aStream nextPutAll: ' 0'].	
