interpreter access
isImmediateObject: objectPointer

	^(objectPointer bitAnd: 1) > 0