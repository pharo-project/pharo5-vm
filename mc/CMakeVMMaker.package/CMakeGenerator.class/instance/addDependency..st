cmake commands
addDependency: aName

	self cmd: 'list'
		params: 'APPEND ', self moduleName , '_dependencies ' , aName.
