C code generator
emitExportsNamed: exportsNamePrefix pluginName: pluginName on: aStream
	"Store all the exported primitives in the form used by the internal named prim system."
	| nilVMClass excludeDepth |
	(nilVMClass := vmClass isNil) ifTrue: "We need a vmClass temporarily to compute accessor depths."
		[vmClass := StackInterpreter].
	"Don't include the depth in the vm's named primitives if the vm is non-Spur."
	excludeDepth := exportsNamePrefix = 'vm'
					  and: [pluginName isEmpty
					  and: [vmClass objectMemoryClass hasSpurMemoryManagerAPI not]].
	aStream cr; cr; nextPutAll: 'static char _m[] = "'; nextPutAll: pluginName; nextPutAll: '";'.
	aStream cr; nextPutAll: 'void* '; nextPutAll: exportsNamePrefix; nextPutAll: '_exports[][3] = {'; cr.
	((methods select: [:m| m export]) asSortedCollection: [:a :b| a selector caseSensitiveLessOrEqual: b selector]) do:
		[:method| | compileTimeOptionPragmas primName |
		(compileTimeOptionPragmas := method compileTimeOptionPragmas) notEmpty ifTrue:
			[method outputConditionalDefineFor: compileTimeOptionPragmas on: aStream].
		 primName := self cFunctionNameFor: method selector.
		 aStream tab; nextPutAll: '{(void*)_m, "'; nextPutAll: primName.
		 excludeDepth ifFalse:
			[(self accessorDepthForSelector: primName asSymbol) ifNotNil:
				[:depth| "store the accessor depth in a hidden byte immediately after the primName"
				self assert: depth < 128.
				aStream
					nextPutAll: '\000\';
					nextPutAll: ((depth bitAnd: 255) printStringBase: 8 nDigits: 3)]].
		 aStream nextPutAll: '", (void*)'; nextPutAll: primName; nextPutAll: '},'; cr.
		 method terminateConditionalDefineFor: compileTimeOptionPragmas on: aStream].
	aStream tab; nextPutAll: '{NULL, NULL, NULL}'; cr; nextPutAll: '};'; cr.
	nilVMClass ifTrue:
		[vmClass := nil]