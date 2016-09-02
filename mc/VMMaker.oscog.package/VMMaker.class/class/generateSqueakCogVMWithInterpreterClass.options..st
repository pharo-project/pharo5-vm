confs-support
generateSqueakCogVMWithInterpreterClass: interpreterClass options: optionsArray
	^VMMaker
		generate: interpreterClass
		and: SimpleStackBasedCogit
		with: optionsArray
		to: (FileDirectory default pathFromURI: self sourceTree, '/src')
		platformDir: (FileDirectory default pathFromURI: self sourceTree, '/platforms')
		including:#()