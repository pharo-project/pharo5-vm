system primitives
primitiveSetGWorldPtrOntoExistingSurface: surfaceID gWorld: bitMapPtr width: width height: height rowBytes: rowBytes depth: depth movie: moviePtr
	| buffer movie |

	self primitive: 'primitiveSetGWorldPtrOntoExistingSurface'  parameters:#(SmallInteger Oop SmallInteger SmallInteger SmallInteger SmallInteger Oop).
	buffer := self cCoerce: (interpreterProxy positive32BitValueOf: bitMapPtr) to: 'char *'.
	movie := self cCoerce: (interpreterProxy positive32BitValueOf: moviePtr) to: 'long'.
	self stQuicktimeSetToExistingSurface: surfaceID gworld: buffer width: width height: height rowBytes: rowBytes depth: depth movie: movie.
	