debug support
symbolicMethod: aMethod
	<doNotGenerate>
	| ts prim |
	(ts := self transcript) ensureCr.
	(prim := self primitiveIndexOf: aMethod) > 0 ifTrue:
		[ts nextPutAll: '<primitive: '; print: prim; nextPut: $>.
		(self isQuickPrimitiveIndex: prim) ifTrue:
			[ts nextPutAll: ' quick method'; cr; flush.
			 ^self].
		ts cr].
	(InstructionPrinter
			on: (VMCompiledMethodProxy new
					for: method
					coInterpreter: self
					objectMemory: self))
		indent: 0;
		printInstructionsOn: ts.
	ts flush