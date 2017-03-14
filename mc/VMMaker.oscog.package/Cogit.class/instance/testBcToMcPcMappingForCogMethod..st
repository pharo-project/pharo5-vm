testing
testBcToMcPcMappingForCogMethod: cogMethod
	<doNotGenerate>
	"self disassembleMethod: cogMethod"
	"self printPCMapPairsFor: cogMethod on: Transcript"
	| aMethodObj subMethods bsOffset |
	aMethodObj := cogMethod methodObject.
	subMethods := self subMethodsAsRangesFor: cogMethod.
	subMethods first endPC: (self endPCOf: aMethodObj).
	bsOffset := self bytecodeSetOffsetFor: aMethodObj.
	self bcpcsDescriptorsAndStartpcsFor: aMethodObj bsOffset: bsOffset do:
		[:bcpc :byte :desc :nExts :startpc|
		(desc notNil and: [desc isBlockCreation]) ifTrue:
			["dead code removal may result in blocks not being generated ;-)"
			 (subMethods detect: [:sm| sm startpc = (bcpc + desc numBytes)] ifNone: [nil]) ifNotNil:
				[:subMethod|
				 subMethod endPC: bcpc + desc numBytes + (self spanFor: desc at: bcpc exts: -1 in: aMethodObj) - 1]]].
	subMethods allButFirst do:
		[:blockSubMethod| | cogBlockMethod |
		cogBlockMethod := self
								findMethodForStartBcpc: blockSubMethod startpc
								inHomeMethod: cogMethod.
		self assert: cogBlockMethod address = (blockSubMethod first - (self sizeof: CogBlockMethod))].
	self bcpcsDescriptorsAndStartpcsFor: aMethodObj bsOffset: bsOffset do:
		[:bcpc :byte :desc :nExts :startpc| | startBcpc currentSubMethod subCogMethod absMcpc mappedBcpc |
		currentSubMethod := self innermostSubMethodFor: bcpc in: subMethods startingAt: 1.
		startpc = currentSubMethod startpc ifTrue:
			[subCogMethod := currentSubMethod cogMethod.
			(subCogMethod stackCheckOffset > 0
			 and: [desc isNil or: [desc isMapped 
			 or: [inBlock = InFullBlock and: [desc isMappedInBlock]]]]) ifTrue:
				[startBcpc := subCogMethod = cogMethod
								ifTrue: [coInterpreter startPCOfMethod: aMethodObj]
								ifFalse: [currentSubMethod startpc].
				 "The first bytecode and backward branch bytecodes are mapped to their pc.
				  Other bytecodes map to their following pc."
				 absMcpc := (desc notNil
							   and: [desc isBranch
							   and: [self isBackwardBranch: desc at: bcpc exts: nExts in: aMethodObj]])
								ifTrue: "Backward branches have a special mapper"
									[mappedBcpc := bcpc.
									 self
										mcPCForBackwardBranch: mappedBcpc
										startBcpc: startBcpc
										in: subCogMethod]
								ifFalse: "All others use the generic mapper"
									[mappedBcpc := desc ifNil: [bcpc] ifNotNil: [bcpc + desc numBytes].
									 self
										mcPCFor: mappedBcpc
										startBcpc: startBcpc
										in: subCogMethod].
				 self assert: absMcpc >= (subCogMethod asInteger + subCogMethod stackCheckOffset).
				 self assert: (self bytecodePCFor: absMcpc startBcpc: startBcpc in: subCogMethod) = mappedBcpc]]]