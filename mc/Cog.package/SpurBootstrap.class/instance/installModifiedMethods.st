bootstrap methods
installModifiedMethods
	"Install all the methods in the class-side method prototypes protocol in the relevant classes
	 in the new image.  First use the simulator to get the image to intern all symbols and add
	 dummy methods under new selectors.  With that done we can manually replace the relevant
	 methods with the prototypes, mapping selectors and global variables as required."
	self withExecutableInterpreter: oldInterpreter
		do: [self internAllSymbols.
			 self addNewMethods.
			 self removeMethods.
			 self replaceMethods.
			 self modifyCharacterMethods]