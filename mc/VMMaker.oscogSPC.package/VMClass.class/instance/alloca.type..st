C library extensions
alloca: numElements type: elementType
	<cmacro: '(numElements, elementType) alloca((numElements)*sizeof(elementType))'>
	^CArrayAccessor on: ((1 to: numElements) collect: [:ign| elementType new])