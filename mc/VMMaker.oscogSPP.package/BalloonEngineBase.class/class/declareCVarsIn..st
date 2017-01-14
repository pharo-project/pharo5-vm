translation
declareCVarsIn: cg

	"Buffers"
	cg var: #workBuffer type: #'int*'.
	cg var: #objBuffer type: #'int*'.
	cg var: #getBuffer type: #'int*'.
	cg var: #aetBuffer type: #'int*'.
	cg var: #spanBuffer type: #'unsigned int*'.
	cg var: #edgeTransform declareC: 'float edgeTransform[6]'.
	cg var: #doProfileStats declareC: 'int doProfileStats = 0'.
	cg var: 'bbPluginName' declareC:'char bbPluginName[256] = "BitBltPlugin"'.
	"Functions"
	cg var: 'copyBitsFn'	type: 'void *'.
	cg var: 'loadBBFn'	type: 'void *'.