utilities
makerFor: interpreterClass and: cogitClassOrNil with: optionsPairsArrayArg to: srcDirName platformDir: platDirName
	"Initialize a VMMaker to generate the VM to the given target directory. Include plugins in pluginList.
	Example:
		(VMMaker
			generate: NewspeakInterpreter
			to: (FileDirectory default pathFromURI: 'cogvm/newspeaksrc')
			platformDir: (FileDirectory default pathFromURI: 'cogvm/platforms')
			including:#(	AsynchFilePlugin FloatArrayPlugin RePlugin B2DPlugin FloatMathPlugin SecurityPlugin
						BMPReadWriterPlugin IA32ABI SocketPlugin BitBltPlugin JPEGReadWriter2Plugin SurfacePlugin
						DSAPrims JPEGReaderPlugin UUIDPlugin DropPlugin LargeIntegers UnixOSProcessPlugin
						FileCopyPlugin Matrix2x3Plugin Win32OSProcessPlugin FilePlugin MiscPrimitivePlugin ZipPlugin))"
	| maker optionsPairsArray |
	maker := self forPlatform: 'Cross'.
	maker sourceDirectoryName: srcDirName.
	maker platformRootDirectoryName: platDirName.
	maker interpreterClass: interpreterClass.
	optionsPairsArray := (cogitClassOrNil isNil or: [optionsPairsArrayArg includes: #Cogit])
							ifNil: [optionsPairsArrayArg]
							ifNotNil: [optionsPairsArrayArg, { #Cogit. cogitClassOrNil name }].
	maker options: optionsPairsArray.
	^maker
