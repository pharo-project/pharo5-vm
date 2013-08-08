exports
targetForLinking
	"Answer a target or path to library to link with, which can be used by 
	external plugins or VM module"

	^ '${ft2libInstalled}/', self libraryFileName