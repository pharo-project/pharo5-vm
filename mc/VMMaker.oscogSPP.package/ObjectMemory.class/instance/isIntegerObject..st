interpreter access
isIntegerObject: objectPointer

	^ (objectPointer bitAnd: 1) > 0