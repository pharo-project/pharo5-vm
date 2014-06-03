utilities
generate: interpreterClass and: cogitClass with: optionsPairsArray to: srcDirName platformDir: platDirName including: inclusions
	"Generate the VM to the given target directory. Include only plugins in pluginList.
	 Example:
		(VMMaker
			generate: CoInterpreter
			and: SimpleStackBasedCogit
			to: (FileDirectory default pathFromURI: '../src')
			platformDir: (FileDirectory default pathFromURI: '../platforms')
			including:#(	AsynchFilePlugin FloatArrayPlugin RePlugin B2DPlugin FloatMathPlugin SecurityPlugin
						BMPReadWriterPlugin IA32ABI SocketPlugin BitBltPlugin JPEGReadWriter2Plugin SurfacePlugin
						DSAPrims JPEGReaderPlugin UUIDPlugin DropPlugin LargeIntegers UnixOSProcessPlugin
						FileCopyPlugin Matrix2x3Plugin Win32OSProcessPlugin FilePlugin MiscPrimitivePlugin ZipPlugin))"
	(self
		makerFor: interpreterClass
		and: cogitClass
		with: optionsPairsArray
		to: srcDirName
		platformDir: platDirName
		including: inclusions) generateEntire