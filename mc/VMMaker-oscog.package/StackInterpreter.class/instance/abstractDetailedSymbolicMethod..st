debug support
abstractDetailedSymbolicMethod: aMethod
	<doNotGenerate>
	| ts prim |
	(ts := self transcript) ensureCr.
	(prim := self primitiveIndexOf: aMethod) > 0 ifTrue:
		[ts nextPutAll: '<primitive: '; print: prim; nextPut: $>.
		(self isQuickPrimitiveIndex: prim) ifTrue:
			[ts nextPutAll: ' quick method'; cr; flush.
			 ^self].
		ts cr].
	(RelativeDetailedInstructionPrinter
			on: (VMCompiledMethodProxy new
					for: aMethod
					coInterpreter: self
					objectMemory: objectMemory))
		indent: 0;
		printInstructionsOn: ts.
	ts flush