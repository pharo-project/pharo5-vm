path access
interpreterClassName
	"return a Text for the path to the generated sources"
	^[vmMaker interpreterClass name asString] 
		on: VMMakerException 
		do:[:ex| ex return:'<invalid class>'].