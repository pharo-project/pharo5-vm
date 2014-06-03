initialisation
isActiveVMMakerClassFor: platformName 
	"Does this class claim to be that properly active subclass of VMMaker for 
	this platform? Subclasses are welcome to override this default"
	^ platformName , '*' match: self name