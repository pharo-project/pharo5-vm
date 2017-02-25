debug support
detailedSymbolicMethod: aMethod
	<doNotGenerate>
	 self transcript
		ensureCr;
		nextPutAll:
			((String streamContents:
				[:ts| | prim proxy |
				(prim := self primitiveIndexOf: aMethod) > 0 ifTrue:
					[ts nextPutAll: '<primitive: '; print: prim; nextPut: $>.
					(self isQuickPrimitiveIndex: prim) ifTrue:
						[ts nextPutAll: ' quick method'; cr; flush.
						 ^self].
					ts cr].
				proxy := VMCompiledMethodProxy new
								for: aMethod
								coInterpreter: self
								objectMemory: objectMemory.
				(DetailedInstructionPrinter on: proxy)
					stackHeightComputer: (StackDepthFinder on: proxy);
					indent: 0;
					printInstructionsOn: ts]) copyReplaceAll: 'a VMObjectProxy for ' with: '');
		flush