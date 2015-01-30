compiled methods
isOptimizedMethod: methodObj
	<api>
	<option: #SistaVM>
	^self isOptimizedMethodHeader: (objectMemory methodHeaderOf: methodObj)