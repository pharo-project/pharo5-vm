android template generation
downloadDrawableRessources
	"http://files.pharo.org/media/logo/icon-lighthouse-128x128.png"
	"ntficon.png"
	| zn form |
	zn := ZnClient new.
	(drawableDir / 'ntficon.png') exists ifFalse:[
		form := (PNGReadWriter createAFormFrom: (
				zn get: 'http://files.pharo.org/media/logo/icon-lighthouse-128x128.png')) first.
	
	PNGReadWriter 
		putForm: form
		onFileNamed: (drawableDir / 'ntficon.png') fullName.
		].
	
	
	"http://files.pharo.org/media/logo/icon-512x512.png"
	"smalltalk.png and icon.png"
	(drawableDir / 'icon.png') exists ifFalse:[
		form := (PNGReadWriter createAFormFrom: (
				zn get: 'http://files.pharo.org/media/logo/icon-512x512.png')) first.
	
	PNGReadWriter 
		putForm: form
		onFileNamed: (drawableDir / 'icon.png') fullName.
	].

	(drawableDir / 'smalltalk.png') exists ifFalse:[
		form := (PNGReadWriter createAFormFrom: (
				zn get: 'http://files.pharo.org/media/logo/icon-512x512.png')) first.
	
	PNGReadWriter 
		putForm: form
		onFileNamed: (drawableDir / 'smalltalk.png') fullName.
	].
	