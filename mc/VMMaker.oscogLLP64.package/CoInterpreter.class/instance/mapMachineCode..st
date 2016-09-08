object memory support
mapMachineCode: theGCMode
	<inline: true>
	"Update all references to objects in machine code."
	cogit mapObjectReferencesInMachineCode: theGCMode