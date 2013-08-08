path access
sourcePathText
	"return a Text for the path to the generated sources"
	^(vmMaker sourceDirectoryName ifNil: ['']),
	  ([vmMaker sourceDirectory. ''] 
		on: VMMakerException 
		do:[:ex| ex return: '<path not valid>']) asText