C code generation
emitCFunctionPrototype: aStream generator: aCodeGen isPrototype: isPrototype "<Boolean>"
	"Emit a C function header for this method onto the given stream.
	 Answer if the method has any compileTimeOptionPragmas"
	| compileTimeOptionPragmas returnTypeIsFunctionPointer |
	(compileTimeOptionPragmas := self compileTimeOptionPragmas) notEmpty ifTrue:
		[self outputConditionalDefineFor: compileTimeOptionPragmas on: aStream].
	returnTypeIsFunctionPointer := returnType notNil
									and: [returnType last = $)
									and: [returnType includesSubString: (aCodeGen cFunctionNameFor: selector)]].
	export 
		ifTrue:
			[aStream nextPutAll: 'EXPORT('; nextPutAll: returnType; nextPut: $)]
		ifFalse:
			[self isStatic
				ifTrue: [aStream nextPutAll: 'static ']
				ifFalse:
					[isPrototype ifTrue:
						[aStream nextPutAll: 'extern ']].
			 (isPrototype or: [inline ~~ #always]) ifFalse: [aStream nextPutAll: 'inline '].
			 aStream nextPutAll: (returnType ifNil: [#sqInt])].
	(functionAttributes isNil or: [returnTypeIsFunctionPointer]) ifFalse:
		[aStream space; nextPutAll: functionAttributes].
	isPrototype ifTrue: [aStream space] ifFalse: [aStream cr].
	returnTypeIsFunctionPointer ifFalse:
		[aStream
			nextPutAll: (aCodeGen cFunctionNameFor: selector);
			nextPut: $(.
		args isEmpty
			ifTrue: [aStream nextPutAll: #void]
			ifFalse:
				[args
					do: [:arg| aStream nextPutAll: (self declarationAt: arg)]
					separatedBy: [aStream nextPutAll: ', ']].
		aStream nextPut: $)].
	isPrototype ifTrue:
		[aStream nextPut: $;; cr.
		 compileTimeOptionPragmas isEmpty ifFalse:
			[aCodeGen maybeEmitPrimitiveFailureDefineFor: selector on: aStream.
			 self terminateConditionalDefineFor: compileTimeOptionPragmas on: aStream]].
	^compileTimeOptionPragmas notEmpty