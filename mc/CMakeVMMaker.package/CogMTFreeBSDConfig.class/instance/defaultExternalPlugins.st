plugins
defaultExternalPlugins

	^ #(
		B3DAcceleratorPlugin
		UUIDPlugin
		ThreadedFFIPlugin "SqueakFFIPrims"
		ThreadedIA32FFIPlugin "SqueakFFIPrims"
		"UnixOSProcessPlugin ?? "
	)