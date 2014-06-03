initialisation
update: anObject 
	"some related object has changed. Try to handle it"
	anObject == #reinitialize ifTrue: [self updateAllViews]