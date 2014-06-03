system primitives
primitiveGetStringKeyedBy: aKey
	| oop ptr size aString keyLength |

	<var: #aString declareC: 'char aString[1025]'>
	<var: #ptr type: 'char *'>
	self primitive: 'primitiveGetStringKeyedBy'
		parameters: #(String).
	
	keyLength := interpreterProxy byteSizeOf: aKey cPtrAsOop.
	size := self sqInternetConfigurationGetStringKeyedBy: aKey keySize: keyLength into: aString.
	oop := interpreterProxy instantiateClass: interpreterProxy classString indexableSize: size.
	ptr := interpreterProxy firstIndexableField: oop.
	0 to: size-1 do:[:i|
		ptr at: i put: (aString at: i)].
	^oop.
