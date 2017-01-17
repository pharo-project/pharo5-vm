initialization
genActiveContextTrampolineLarge: isLarge inBlock: isInBlock called: aString
	<var: #aString type: #'char *'>
	"Create a trampoline to answer the active context that will
	 answer it if a frame is already married, and create it otherwise.
	 Assume numArgs is in SendNumArgsReg and ClassReg is free."
	| startAddress |
	startAddress := cogit methodZoneBase.
	cogit zeroOpcodeIndex.
	self genGetActiveContextLarge: isLarge inBlock: isInBlock.
	cogit outputInstructionsForGeneratedRuntimeAt: startAddress.
	cogit recordGeneratedRunTime: aString address: startAddress.
	cogit recordRunTimeObjectReferences.
	^startAddress