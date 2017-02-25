utilities
openCogitMultiWindowBrowser
	"Answer a new multi-window browser on the ObjectMemory classes, the Cog Interpreter classes, and the main JIT classes"
	"self openCogitMultiWindowBrowser"
	| b |
	b := Browser open.
	Cogit withAllSubclasses,
	CogObjectRepresentation withAllSubclasses,
	{CogMethodZone. CogRTLOpcodes },
	(CogAbstractInstruction withAllSubclasses reject: [:c| c name endsWith: 'Tests']),
	{VMStructType. VMMaker. CCodeGenerator. TMethod}
		do: [:class|
			b selectCategoryForClass: class; selectClass: class]
		separatedBy:
			[b multiWindowState addNewWindow].
	b multiWindowState selectWindowIndex: 1