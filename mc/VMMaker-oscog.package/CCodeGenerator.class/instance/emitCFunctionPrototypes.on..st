C code generator
emitCFunctionPrototypes: methodList on: aStream 
	"Store prototype declarations for all non-inlined methods on the given stream."
	| exporting |
	aStream cr; nextPutAll: '/*** Function Prototypes ***/'; cr.
	exporting := false.
	(methodList select: [:m| m isRealMethod]) do:
		[:m |
		self emitExportPragma ifTrue:
			[m export
				ifTrue: [exporting ifFalse: 
							[aStream nextPutAll: '#pragma export on'; cr.
							exporting := true]]
				ifFalse: [exporting ifTrue: 
							[aStream nextPutAll: '#pragma export off'; cr.
							exporting := false]]].
		m emitCFunctionPrototype: aStream generator: self.
		aStream nextPut: $; ; cr].
	exporting ifTrue: [aStream nextPutAll: '#pragma export off'; cr].
	aStream cr