plugins
defaultExternalPlugins

	^ #(
		BochsIA32Plugin
		CroquetPlugin
		ThreadedIA32FFIPlugin "SqueakFFIPrims"
		FloatArrayPlugin
		FloatMathPlugin
		Mpeg3Plugin
		QuicktimePlugin
"		TestOSAPlugin  - not works"
		"UnixOSProcessPlugin ?? "
		)