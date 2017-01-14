path access
platformsPathText
	"return a Text for the path to the platform sources"
	^(vmMaker platformRootDirectoryName ifNil: ['']),
	  ([vmMaker platformRootDirectory. ''] 
		on: VMMakerException 
		do:[:ex| ex return: '<path not valid>']) asText