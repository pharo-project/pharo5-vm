scripts generation
mcPackage: name
	
	|pkg|
	pkg := MCWorkingCopy allManagers detect: [:ea | ea packageName = name ].
	
	^ pkg ancestry ancestorString , '.mcz'
	