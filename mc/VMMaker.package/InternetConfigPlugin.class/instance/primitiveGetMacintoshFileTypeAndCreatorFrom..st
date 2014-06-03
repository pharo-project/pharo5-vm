system primitives
primitiveGetMacintoshFileTypeAndCreatorFrom: aFileName
	| oop ptr keyLength creator |

	<var: #creator declareC: 'char creator[8]'>
	<var: #ptr type: 'char *'>
	self primitive: 'primitiveGetMacintoshFileTypeAndCreatorFrom'
		parameters: #(String).

	keyLength := interpreterProxy byteSizeOf: aFileName cPtrAsOop.
	self sqInternetGetMacintoshFileTypeAndCreatorFrom: aFileName keySize: keyLength into: creator.
	oop := interpreterProxy instantiateClass: interpreterProxy classString indexableSize: 8.
	ptr := interpreterProxy firstIndexableField: oop.
	0 to: 7 do:[:i|
		ptr at: i put: (creator at: i)].
	^oop.
