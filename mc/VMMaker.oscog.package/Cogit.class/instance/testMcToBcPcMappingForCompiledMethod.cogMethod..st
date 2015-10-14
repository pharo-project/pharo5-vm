tests-method map
testMcToBcPcMappingForCompiledMethod: aCompiledMethod cogMethod: cogMethod
	<doNotGenerate>
	| bcMethod subMethods prevMcpc |
	"self disassembleMethod: cogMethod"
	"coInterpreter symbolicMethod: cogMethod methodObject"
	"coInterpreter printOop: cogMethod methodObject"
	"self printPCMapPairsFor: cogMethod on: Transcript"
	cogMethod stackCheckOffset = 0 ifTrue: "frameless"
		[^self].
	bcMethod := coInterpreter isCurrentImageFacade
					ifTrue: [coInterpreter objectForOop: cogMethod methodObject]
					ifFalse: [VMCompiledMethodProxy new
								for: cogMethod methodObject
								coInterpreter: coInterpreter
								objectMemory: objectMemory].
	subMethods := self subMethodsAsRangesFor: cogMethod.
	self mapFor: cogMethod do:
		[:annotation :mcpc| | subMethod subCogMethod bcpc mappedpc |
		(self isPCMappedAnnotation: annotation) ifTrue:
			[subMethod := subMethods
								detect: [:range| range includes: mcpc]
								ifNone: ["a trailing call ceNonLocalReturnTrampoline's following
										 pc is the start of a following block or the end of the map"
										subMethods detect: [:range| range includes: mcpc - 1]].
			mcpc > subMethod first ifTrue:
				[bcpc := self
							bytecodePCFor: mcpc
							startBcpc: subMethod startpc
							in: (subCogMethod := subMethod cogMethod).
				self assert: bcpc ~= 0.
				mappedpc := self mcPCFor: bcpc startBcpc: subMethod startpc in: subCogMethod.
				subCogMethod stackCheckOffset = 0
					ifTrue: [self assert: mappedpc > (subCogMethod address + self noCheckEntryOffset)]
					ifFalse: [self assert: mappedpc >= (subCogMethod address + subCogMethod stackCheckOffset)].
				"mcpc = mappedpc is obviously what we want and expect.  prevMcpc = mappedpc hacks
				 around frame building accessors where the first bytecode is mapped twice, once for the
				 stack check and once for the context inst var access.  The bytecode pc can only map
				 back to a single mcpc, the first, so the second map entry will fail without this hack."
				self assert: (mcpc = mappedpc or: [prevMcpc = mappedpc]).
				(self isSendAnnotation: annotation) ifTrue:
					[| mcSelector bcSelector |
					mcSelector := self selectorForSendAt: mcpc annotation: annotation in: aCompiledMethod.
					"sends map to the following pc.  need to find the selector for the previous pc"
					bcSelector := self selectorForSendBefore: bcpc in: bcMethod.
					self assert: mcSelector = bcSelector]].
			 prevMcpc := mcpc].
		 false "keep scanning"]