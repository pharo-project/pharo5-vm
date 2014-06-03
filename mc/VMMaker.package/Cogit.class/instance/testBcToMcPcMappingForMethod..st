tests-method map
testBcToMcPcMappingForMethod: cogMethod
	<doNotGenerate>
	"self disassembleMethod: cogMethod"
	"self printPCMapPairsFor: cogMethod on: Transcript"
	| aMethodObj currentSubMethod subMethods |
	aMethodObj := cogMethod methodObject.
	subMethods := self subMethodsAsRangesFor: cogMethod.
	currentSubMethod := subMethods first.
	currentSubMethod endPC: (self endPCOf: aMethodObj).
	self bcpcsAndDescriptorsFor: aMethodObj do:
		[:bcpc :byte :desc| | subMethod |
		(desc notNil and: [desc isBlockCreation]) ifTrue:
			[subMethod := subMethods detect: [:sm| sm startpc = (bcpc + desc numBytes)].
			 subMethod endPC: bcpc + desc numBytes + (self spanFor: desc at: bcpc exts: -1 in: aMethodObj) - 1]].
	subMethods allButFirst do:
		[:blockSubMethod| | cogBlockMethod |
		cogBlockMethod := self
								findMethodForStartBcpc: blockSubMethod startpc
								inHomeMethod: cogMethod.
		self assert: cogBlockMethod address = (blockSubMethod first - (self sizeof: CogBlockMethod))].
	self bcpcsAndDescriptorsFor: aMethodObj do:
		[:bcpc :byte :desc| | absMcpc mappedBcpc |
		currentSubMethod := self innermostSubMethodFor: bcpc in: subMethods startingAt: 1.
		(currentSubMethod cogMethod stackCheckOffset > 0
		 and: [desc isNil or: [desc isMapped]]) ifTrue:
			["The first bytecode and backward branch bytecodes are mapped to their pc.
			  Other bytecodes map to their following pc."
			mappedBcpc := (desc isNil
							   or: [desc isBranch
								   and: [(self isBackwardBranch: desc at: bcpc exts: (self nExtensionsFor: bcpc in: aMethodObj) in: aMethodObj)]])
								ifTrue: [bcpc]
								ifFalse: [bcpc + desc numBytes].
			 absMcpc := self
							mcPCFor: mappedBcpc
							startBcpc: currentSubMethod startpc
							in: currentSubMethod cogMethod.
			 self assert: absMcpc > (currentSubMethod cogMethod asInteger + self noCheckEntryOffset).
			 self assert: (self
							bytecodePCFor: absMcpc
							startBcpc: currentSubMethod startpc
							in: currentSubMethod cogMethod) = mappedBcpc]]