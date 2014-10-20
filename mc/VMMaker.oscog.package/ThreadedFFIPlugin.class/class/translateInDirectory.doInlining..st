translation
translateInDirectory: directory doInlining: inlineFlag
	"As a hack to allow ThreadedFFIPlugin to generate a skeletal SqueakFFIPrims.c that
	 simply includes the fleshed-out SqueakIA32FFIPrims.c, SqueakARMFFIPrims.c et al,
	 intercept for ThreadedFFIPlugin and output generateCodeStringForPrimitives."
	| ffiPluginRootClass |
	ffiPluginRootClass := thisContext method methodClass soleInstance.
	^self == ffiPluginRootClass
		ifTrue:
			[self
				storeString: self generateCodeStringForPrimitives
				onFileNamed: (directory fullNameFor: self moduleName, '.c').
			#()]
		ifFalse:
			[super
				translateInDirectory: (directory containingDirectory directoryNamed: ffiPluginRootClass moduleName) assureExistence
				doInlining: inlineFlag]