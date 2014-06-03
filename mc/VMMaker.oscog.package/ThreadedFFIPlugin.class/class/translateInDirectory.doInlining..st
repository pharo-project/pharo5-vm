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
				onFileNamed: (directory asFileReference / (self moduleName, '.c')) fullName.
			#()]
		ifFalse:
			[super
				translateInDirectory: (directory asFileReference parent / ffiPluginRootClass moduleName) ensureCreateDirectory 
				doInlining: inlineFlag]