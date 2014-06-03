system primitives
primitiveSetGWorldPtrOntoSurface: bitMapPtr width: width height: height rowBytes: rowBytes depth: depth movie: moviePtr
	| buffer movie results |

	self primitive: 'primitiveSetGWorldPtrOntoSurface'  parameters:#(Oop SmallInteger SmallInteger SmallInteger SmallInteger Oop).
	buffer := self cCoerce: (interpreterProxy positive32BitValueOf: bitMapPtr) to: 'char *'.
	movie := self cCoerce: (interpreterProxy positive32BitValueOf: moviePtr) to: 'long'.
	results := self stQuicktimeSetSurface: buffer width: width height: height rowBytes: rowBytes depth: depth movie: movie.
	^results asOop: SmallInteger 