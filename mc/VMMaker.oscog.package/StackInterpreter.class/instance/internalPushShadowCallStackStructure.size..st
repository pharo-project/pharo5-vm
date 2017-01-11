internal interpreter access
internalPushShadowCallStackStructure: structurePointer size: size
	<option: #LowcodeVM>
	shadowCallStackPointer := shadowCallStackPointer - size.
	self lowcode_mem: shadowCallStackPointer cp: structurePointer y: size