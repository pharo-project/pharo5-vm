plugins
defaultExternalPlugins
	^ #(
		B3DAcceleratorPlugin
		ThreadedIA32FFIPlugin "SqueakFFIPrims"
		"UUIDPlugin"
		"UnixOSProcessPlugin ?? "	
		JPEGReaderPlugin 
		JPEGReadWriter2Plugin 			
		RePlugin
		InternetConfigPlugin
	)