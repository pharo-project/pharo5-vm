version identification
versionInformation

	"OSProcessPlugin versionInformation"

	| osp ospString |
	osp := Smalltalk at: #OSProcess ifAbsent: [].
	ospString := osp isNil
		ifTrue:
			[' (OSProcess not installed in this image)']
		ifFalse:
			[' installed with OSProcess version ', osp versionString].
	^ self vmVersion, ' with ', self concreteClass moduleName, ' version ',
		self versionString, ' using concrete class ', self concreteClass name,
		ospString, ', running on ', ((self getSystemAttribute: 1002) asString),
		' ', self platformName, ' VM with installed plugin ',
		(self canAccessSystem
			ifTrue:
				[self concreteClass installedModuleName isNil
					ifTrue:
						['(old version of plugin cannot identify itself)']
					ifFalse:
						[self concreteClass installedModuleName, ' version ',
						self installedModuleVersionString,
						((self versionString = self concreteClass installedModuleVersionString)
							ifTrue: [' (plugin matches class in image)']
							ifFalse: [' (plugin does not match class in image)'])]]
			ifFalse:
				['(OSProcessPlugin installed module not accessible)'])

