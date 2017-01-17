initialize-release
method: aMethod pc: pc
	super method: aMethod.
	stackHeightComputer := StackDepthFinder new method: aMethod pc: pc