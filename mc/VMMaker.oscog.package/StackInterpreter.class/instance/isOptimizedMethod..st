compiled methods
isOptimizedMethod: header
	<api>
	<option: #SistaVM>
	^header >> MethodHeaderFlagBitPosition anyMask: 1