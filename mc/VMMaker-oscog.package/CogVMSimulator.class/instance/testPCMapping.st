testing
testPCMapping
	objectMemory allObjectsDo:
		[:o|
		((objectMemory isCompiledMethod: o)
		 and: [self methodShouldBeCogged: o]) ifTrue:
			[(self methodHasCogMethod: o) ifFalse:
				[[([cogit cog: o selector: objectMemory nilObject]
					on: Error
					do: [:ex|
						ex messageText = 'This won''t work...' ifTrue:
							[ex resumeUnchecked: nil].
						ex pass]) isNil
				   and: [cogCompiledCodeCompactionCalledFor]] whileTrue:
					[cogMethodZone clearCogCompiledCode.
					 cogCompiledCodeCompactionCalledFor := false]].
			 (self methodHasCogMethod: o)
				ifTrue:
					[transcript nextPut: $.; flush.
					 cogit testMcToBcPcMappingForMethod: (self cogMethodOf: o)]
				ifFalse:
					[transcript nextPutAll: 'failed to compile method '; print: o; cr; flush]]]