tests-method map
testMcToBcPcMappingForMethod: cogMethod
	<doNotGenerate>
	| bcMethod subMethods prevMcpc isAltInstSet |
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
	isAltInstSet := coInterpreter headerIndicatesAlternateBytecodeSet: cogMethod methodHeader.
	self mapFor: cogMethod do:
		[:annotation :mcpc| | subMethod bcpc mappedpc |
		(self isPCMappedAnnotation: annotation alternateInstructionSet: isAltInstSet) ifTrue:
			[subMethod := subMethods
								detect: [:range| range includes: mcpc]
								ifNone: ["a trailing call ceNonLocalReturnTrampoline's following
										 pc is the start of a following block or the end of the map"
										subMethods detect: [:range| range includes: mcpc - 1]].
			mcpc > subMethod first ifTrue:
				[bcpc := self
							bytecodePCFor: mcpc
							startBcpc: subMethod startpc
							in: subMethod cogMethod.
				self assert: bcpc ~= 0.
				mappedpc := self mcPCFor: bcpc startBcpc: subMethod startpc in: subMethod cogMethod.
				self assert: mappedpc > (subMethod cogMethod address + self noCheckEntryOffset).
				"mcpc = mappedpc is obviously what we want and expect.  PrevMcpc = mappedpc hacks
				 around frame building accessors where the first bytecode is mapped twice, once for the
				 stack check and once for the context inst var access.  The bytecode pc can only map
				 back to a single mcpc, the first, so the second map entry will fail without this hack."
				self assert: (mcpc = mappedpc or: [prevMcpc = mappedpc]).
				"IsNSSendCall is used only for pushImplicitReceiver:.  This isn't a send bytecode.
				 So filter-out these annotations."
				((self isSendAnnotation: annotation) and: [annotation ~= IsNSSendCall]) ifTrue:
					[| mcSelector bcSelector |
					mcSelector := self selectorForSendAt: mcpc annotation: annotation.
					"sends map to the following pc.  need to find the selector for the previous pc"
					bcSelector := self selectorForSendBefore: bcpc in: bcMethod.
					self assert: mcSelector = bcSelector]].
			 prevMcpc := mcpc].
		 false "keep scanning"]