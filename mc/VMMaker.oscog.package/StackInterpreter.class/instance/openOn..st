simulation
openOn: fileName
	"(StackInterpreterSimulator new openOn: 'clonex.image') openAsMorph; run"
	<doNotGenerate>
	objectMemory hasSpurMemoryManagerAPI ifTrue:
		[| fileSize potSize |
		fileSize := (FileDirectory directoryEntryFor: fileName)
						ifNotNil: [:ent| ent fileSize]
						ifNil: [((FileDoesNotExistException fileName: fileName) readOnly: true) signal].
		potSize := 1 << (fileSize - 1) highBit.
		^self openOn: fileName extraMemory: potSize / 4 + potSize - fileSize].
	self openOn: fileName extraMemory: 2500000