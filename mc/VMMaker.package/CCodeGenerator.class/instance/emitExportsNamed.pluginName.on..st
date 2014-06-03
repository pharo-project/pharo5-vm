C code generator
emitExportsNamed: exportsNamePrefix pluginName: pluginName on: aStream
	"Store all the exported primitives in the form used by the internal named prim system."
	| nilVMClass excludeDepth |
	(nilVMClass := vmClass isNil) ifTrue:
		[vmClass := StackInterpreter].
	"Don't include the depth in the vm's named primitives if the vm is non-Spur."
	excludeDepth := exportsNamePrefix = 'vm'
					  and: [pluginName isEmpty
					  and: [vmClass objectMemoryClass hasSpurMemoryManagerAPI not]].
	aStream cr; cr; nextPutAll: 'void* '; nextPutAll: exportsNamePrefix; nextPutAll: '_exports[][3] = {'.
	(self sortStrings: self exportedPrimitiveNames) do:
		[:primName|
		 aStream cr; tab;
			nextPutAll: '{"'; 
			nextPutAll: pluginName; 
			nextPutAll: '", "'; 
			nextPutAll: primName.
		 excludeDepth ifFalse:
			[(self accessorDepthForSelector: primName asSymbol) ifNotNil:
				[:depth| "store the accessor depth in a hidden byte immediately after the primName"
				self assert: depth < 128.
				aStream
					nextPutAll: '\000\';
					nextPutAll: ((depth bitAnd: 255) printStringBase: 8 nDigits: 3)]].
		 aStream
			nextPutAll: '", (void*)'; 
			nextPutAll: primName;
			nextPutAll: '},'].
	aStream cr; tab; nextPutAll: '{NULL, NULL, NULL}'; cr; nextPutAll: '};'; cr.
	nilVMClass ifTrue:
		[vmClass := nil]