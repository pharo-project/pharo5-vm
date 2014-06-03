image save/restore
imageFormatForwardCompatibilityVersion
	"This VM is forwards-compatible with the immediately following closure version, and
	 will write the new version number in snapshots if the closure creation bytecode is used."

	BytesPerWord == 4
		ifTrue: [^6504]
		ifFalse: [^68002]