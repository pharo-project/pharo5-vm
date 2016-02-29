*CogVMMakerPharoCompatibility
block
	
	"This method keeps the compatibility with the simulator.
	The temporary variable name is chosen on purpose because
	
	#asTranslationMethodOfClass:
	
	depends on it, as it will read it in some other context we cannot yet change."
	| superMethod |
	superMethod := self.
	^ (self asOldASTInClass: self methodClass) block