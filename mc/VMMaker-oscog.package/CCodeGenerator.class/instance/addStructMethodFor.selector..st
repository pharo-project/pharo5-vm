utilities
addStructMethodFor: aClass selector: selector 
	"Add the given struct method to the code base and answer its translation
	 or nil if it shouldn't be translated."
	^(self addMethodFor: aClass selector: selector) ifNotNil:
		[:tmethod|
		tmethod transformToStructClassMethodFor: self.
		tmethod]