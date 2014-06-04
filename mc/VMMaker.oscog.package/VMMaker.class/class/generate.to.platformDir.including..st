utilities
generate: interpreterClass to: srcDirName platformDir: platDirName including: inclusions
	"Generate the VM to the given target directory. Include only plugins in pluginList.
	 Example:
		(VMMaker
			generate: NewspeakInterpreter
			to: (FileDirectory default pathFromURI: 'cogvm/newspeaksrc')
			platformDir: (FileDirectory default pathFromURI: 'cogvm/platforms')
			including:#(	AsynchFilePlugin FloatArrayPlugin RePlugin B2DPlugin FloatMathPlugin SecurityPlugin
						BMPReadWriterPlugin IA32ABI SocketPlugin BitBltPlugin JPEGReadWriter2Plugin SurfacePlugin
						DSAPrims JPEGReaderPlugin UUIDPlugin DropPlugin LargeIntegers UnixOSProcessPlugin
						FileCopyPlugin Matrix2x3Plugin Win32OSProcessPlugin FilePlugin MiscPrimitivePlugin ZipPlugin))."
	self generate: interpreterClass with: #() to: srcDirName platformDir: platDirName including: inclusions