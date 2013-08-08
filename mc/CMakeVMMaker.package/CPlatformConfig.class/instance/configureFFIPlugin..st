plugin extra rules
configureFFIPlugin: maker
	"extra rules for FFIPlugin"

	" it is incomplete right now, because in Cog this plugin are not used anymore"
	maker doNotGenerate: true.
	maker addCrossSources: #('sqFFIPlugin.c').