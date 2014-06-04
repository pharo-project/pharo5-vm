C code generator
emitExportsOn: aStream
	"Store all the exported primitives in the form used by the internal named prim system."
	(vmClass isNil or: [vmClass isInterpreterClass]) ifTrue:
		[self emitExportsNamed: 'vm' pluginName: '' on: aStream]