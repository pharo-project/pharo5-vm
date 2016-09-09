internal interpreter access
internalPushShadowCallStackStructure: structurePointer size: size
	<option: #LowcodeVM>
	shadowCallStackPointer := shadowCallStackPointer - size.
	self mem: shadowCallStackPointer cp: structurePointer y: size