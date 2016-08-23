utilities
makerFor: interpreterClass and: cogitClassOrNil to: srcDirName platformDir: platDirName
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
	| maker |
	maker := self forPlatform: 'Cross'.
	maker sourceDirectoryName: srcDirName.
	maker platformRootDirectoryName: platDirName.
	maker interpreterClass: interpreterClass.
	cogitClassOrNil ifNotNil: [maker cogitClass: cogitClassOrNil].
	^maker
