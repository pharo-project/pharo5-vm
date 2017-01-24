debug support
symbolicMethod: aMethod
	<doNotGenerate>
	 self transcript
		ensureCr;
		nextPutAll:
			((String streamContents:
				[:ts| | prim |
				(prim := self primitiveIndexOf: aMethod) > 0 ifTrue:
					[ts nextPutAll: '<primitive: '; print: prim; nextPut: $>.
					(self isQuickPrimitiveIndex: prim) ifTrue:
						[ts nextPutAll: ' quick method'; cr; flush.
						 ^self].
					ts cr].
				(InstructionPrinter
						on: (VMCompiledMethodProxy new
								for: aMethod
								coInterpreter: self
								objectMemory: objectMemory))
					indent: 0;
					printInstructionsOn: ts]) copyReplaceAll: 'a VMObjectProxy for ' with: '');
		flush