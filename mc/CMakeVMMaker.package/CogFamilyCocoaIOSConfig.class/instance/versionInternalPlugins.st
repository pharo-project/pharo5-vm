plugins
versionInternalPlugins 
	"Cog Version Specific Plugins. Some times you can't use same plugins in a version (for instance, CogMT uses a diferent FFI, and you can't build IA32ABIPlugin in MT for now)"
	^Array 
		with: #FFIPlugin
		with: #IA32ABIPlugin