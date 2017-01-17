cog jit support
isOptimizedMethod: methodObj
	^coInterpreter isOptimizedMethodHeader: (self methodHeaderOf: methodObj)