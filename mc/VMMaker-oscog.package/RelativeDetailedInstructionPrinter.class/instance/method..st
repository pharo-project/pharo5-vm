initialize-release
method: aMethod
	super method: aMethod.
	stackHeightComputer := StackDepthFinder new method: aMethod pc: nil