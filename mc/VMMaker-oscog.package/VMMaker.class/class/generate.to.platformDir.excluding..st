utilities
generate: interpreterClass to: srcDirName platformDir: platDirName excluding: exclusions
	"Generate the VM to the given target directory. Exclude plugins in pluginList.
	 Example:
		(VMMaker
			generate: CoInterpreter
			to: (FileDirectory default pathFromURI: '../src')
			platformDir: (FileDirectory default pathFromURI: '../platforms')
			excluding:#(
				BrokenPlugin DShowVideoDecoderPlugin IA32ABIPluginSimulator
				NewsqueakIABIPlugin NewsqueakIABIPluginAttic
				QuicktimePlugin QVideoCodecPlugin QwaqMediaPlugin
				SlangTestPlugin TestOSAPlugin ThreadedFFIPlugin 
				Win32OSProcessPlugin
			))."
	(self
		makerFor: interpreterClass
		and: nil
		with: #()
		to: srcDirName
		platformDir: platDirName
		excluding: exclusions) generateEntire