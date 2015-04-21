inline cacheing
outputMachineCodeAt: address
	"By default move machine code a byte at a time
	  Subclasses with coarser granularity can override as desired."
	<inline: true>
	0 to: machineCodeSize - 1 by: 4 do:
		[:j|
		objectMemory longAt: address + j put: (machineCode at: j // 4)]