objects from disk
configurationInfo
	"build a simple Array of the configuration information that would be 
	 usefully saved for later reloading:- 
		the list of internal & external plugins,
		the flags,
		the platform name,
		the two major directory names,
		bytePerWord
		two flags indicating whether each directory is relative to the current directory or not.
		the interpreter class name"
	| isRelative makeRelative |
	isRelative := [:pn| pn beginsWith: FileDirectory default pathName].
	makeRelative := [:pn|
					(isRelative value: pn)
						ifTrue: [pn allButFirst: FileDirectory default pathName size + 1]
						ifFalse: [pn]].
	^{ internalPlugins asArray.
		externalPlugins asArray.
		inline.
		forBrowser.
		platformName.
		makeRelative value: self sourceDirectory pathName.
		makeRelative value: self platformRootDirectory pathName.
		self wordSize.
		isRelative value: self sourceDirectory pathName.
		isRelative value: self platformRootDirectory pathName.
		self interpreterClassName
	  }