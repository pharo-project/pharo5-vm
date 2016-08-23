system primitives
primitiveSetGWorldPtrOntoExistingSurface: surfaceID gWorld: bitMapPtr width: width height: height rowBytes: rowBytes depth: depth movie: moviePtr
	| buffer movie |

	<var: #buffer type: #'char *'>
	<var: #movie type: #'sqIntptr_t'>
	self primitive: 'primitiveSetGWorldPtrOntoExistingSurface'  parameters:#(SmallInteger Oop SmallInteger SmallInteger SmallInteger SmallInteger Oop).
	buffer := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: bitMapPtr) to: 'char *'.
	movie := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: moviePtr) to: #'sqIntptr_t'.
	self stQuicktimeSetToExistingSurface: surfaceID gworld: buffer width: width height: height rowBytes: rowBytes depth: depth movie: movie.
	