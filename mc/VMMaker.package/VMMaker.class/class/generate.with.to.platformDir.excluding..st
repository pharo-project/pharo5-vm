utilities
generate: interpreterClass with: optionsPairsArray to: srcDirName platformDir: platDirName excluding: exclusions
	"Generate the VM to the given target directory. Include only plugins in pluginList.
	 Example:
		(VMMaker
			generate: StackInterpreter
			with: #(ObjectMemory Spur32BitMemoryManager)
			to: (FileDirectory default directoryNamed: 'oscogvm/spurstacksrc') fullName
			platformDir: (FileDirectory default directoryNamed: 'oscogvm/platforms') fullName
			excluding: (InterpreterPlugin withAllSubclasses collect: [:ea| ea name]))."
	(self makerFor: interpreterClass and: nil with: optionsPairsArray to: srcDirName platformDir: platDirName excluding: exclusions) generateEntire