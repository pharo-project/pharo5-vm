accessing
commonCompilerFlags
	"Common compiler flags"
	^{
	'-arch i386'. 
	'-mmacosx-version-min=10.5'. 
	'-DHAVE_UUID_GENERATE'. 
	'-DDEFAULT_IMAGE_NAME="', self executableName, '.image"'.
	'-DmacintoshSqueak'}