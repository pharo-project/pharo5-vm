C code generation
emitProxyFunctionPrototype: aStream generator: aCodeGen
	"Emit an indirect C function header for this method onto the given stream."

	aStream
		nextPutAll: returnType;
		space;
		nextPutAll: '(*';
		nextPutAll: (aCodeGen cFunctionNameFor: selector);
		nextPutAll: ')('.
	args isEmpty
		ifTrue: [aStream nextPutAll: #void]
		ifFalse:
			[args
				do: [:arg| aStream nextPutAll: (self declarationAt: arg)]
				separatedBy: [ aStream nextPutAll: ', ' ]].
	aStream nextPut: $)