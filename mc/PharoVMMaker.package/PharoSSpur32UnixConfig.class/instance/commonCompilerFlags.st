compiler flags
commonCompilerFlags 
	^super commonCompilerFlags, {  
		'-DIMAGE_DIALECT_NAME="', self executableName, '" '.
		'-DIMAGE_ENV_NAME="PHARO_IMAGE"'.
		'-DDEFAULT_IMAGE_NAME="', self executableName, '.image"'.
		'-DSPURVM'.
		'-DPharoVM' }