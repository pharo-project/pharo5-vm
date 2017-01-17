utilities
generate: interpreterClass and: cogitClass to: srcDirName platformDir: platDirName excluding: exclusions
	"Generate the VM to the given target directory. Exclude plugins in pluginList.
	 Example:
		(VMMaker
			generate: CoInterpreter
			and: SimpleStackBasedCogit
			to: (FileDirectory default pathFromURI: '../src')
			platformDir: (FileDirectory default pathFromURI: '../platforms')
			excluding:#(
				BrokenPlugin DShowVideoDecoderPlugin IA32ABIPluginSimulator
				NewsqueakIABIPlugin NewsqueakIABIPluginAttic
				QuicktimePlugin QVideoCodecPlugin QwaqMediaPlugin
				SlangTestPlugin TestOSAPlugin ThreadedFFIPlugin 
				Win32OSProcessPlugin
			))"
	(self
		makerFor: interpreterClass
		and: cogitClass
		with: #()
		to: srcDirName
		platformDir: platDirName
		excluding: exclusions) generateEntire