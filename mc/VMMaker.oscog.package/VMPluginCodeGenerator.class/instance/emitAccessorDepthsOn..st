C code generator
emitAccessorDepthsOn: aStream 
	"Output accessor depth bytes for all primitives in the plugin.
	 This is for external primitives in Spur."
	(self sortStrings: self exportedPrimitiveNames) do:
		[:primName|
		 (self accessorDepthForSelector: primName asSymbol) ifNotNil:
			[:depth|
			 "store the accessor depth in a byte variable; save a little space
			  by omitting depths < 0; support code supplies the default."
			 self assert: depth < 128.
			 depth >= 0 ifTrue:
				[aStream
					nextPutAll: 'signed char ';
					nextPutAll: primName;
					nextPutAll: 'AccessorDepth = ';
					nextPutAll: (self cLiteralFor: depth);
					nextPut: $;;
					cr]]]