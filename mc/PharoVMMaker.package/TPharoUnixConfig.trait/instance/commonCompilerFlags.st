compiler flags
commonCompilerFlags 
	^super commonCompilerFlags, {
		'-D_FILE_OFFSET_BITS=64'.
		'-DIMAGE_DIALECT_NAME="', self executableName, '" '.
		'-DIMAGE_ENV_NAME="PHARO_IMAGE"'.
		'-DDEFAULT_IMAGE_NAME="', self executableName, '.image"' }