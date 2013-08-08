plugin-testing
pluginTransformData: forward
	"Plugin testing -- if the primitive is not implemented 
	or cannot be found run the simulation. See also: FFTPlugin"
	<primitive: 'primitiveFFTTransformData' module: 'FFTPlugin'>
	^(Smalltalk at: #FFTPlugin ifAbsent:[^self primitiveFailed])
		doPrimitive: 'primitiveFFTTransformData'.