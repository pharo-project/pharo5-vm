plugins
defaultExternalPlugins

	^ #(
		BochsIA32Plugin
		CroquetPlugin
		ThreadedFFIPlugin "SqueakFFIPrims"
		ThreadedIA32FFIPlugin 
		FloatArrayPlugin
		FloatMathPlugin
		Mpeg3Plugin
		QuicktimePlugin
"		TestOSAPlugin  - not works"
		"UnixOSProcessPlugin ?? "
		)