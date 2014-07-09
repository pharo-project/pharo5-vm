method prototypes
ClassPROTOTYPEimmediateSubclass: t instanceVariableNames: f classVariableNames: d poolDictionaries: s category: cat 
	"This is the standard initialization message for creating a new
	 immediate class as a subclass of an existing class (the receiver)."
	^ClassBuilder new
		superclass: self
		immediateSubclass: t
		instanceVariableNames: f
		classVariableNames: d
		poolDictionaries: s
		category: cat