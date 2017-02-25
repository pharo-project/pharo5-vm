*VMMaker-translation support
debugCode: aBlock 
	"Sending this message tells the code generator that there is debug code in 
	aBlock. Debug code will be be generated only, if the correponding flag 
	has been set by TestCodeGenerator>>generateDebugCode:.
	In ST simulation just perform the debug code."
	false ifTrue: [aBlock value]