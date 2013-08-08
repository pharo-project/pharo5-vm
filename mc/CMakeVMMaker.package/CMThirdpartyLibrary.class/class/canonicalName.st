accessing
canonicalName
	"answer the library canonical name, like 
		'freetype2'
		or 'cairo' 
		etc.
		
	Note , this method is used to find the corresponding library
	from all subclasses of CMThirdpartyLibrary	
	"
	^ self subclassResponsibility