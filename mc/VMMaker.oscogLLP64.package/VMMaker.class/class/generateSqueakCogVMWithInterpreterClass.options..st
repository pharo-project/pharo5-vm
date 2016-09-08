confs-support
generateSqueakCogVMWithInterpreterClass: interpreterClass options: optionsArray
	^VMMaker
		generate: interpreterClass
		and: StackToRegisterMappingCogit
		with: optionsArray
		to: (FileDirectory default pathFromURI: self sourceTree, '/src')
		platformDir: (FileDirectory default pathFromURI: self sourceTree, '/platforms')
		including:#()