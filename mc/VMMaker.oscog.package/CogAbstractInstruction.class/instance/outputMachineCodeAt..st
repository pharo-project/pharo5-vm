encoding
outputMachineCodeAt: address
	"By default move machine code a byte at a time
	  Subclasses with coarser granularity can override as desired."
	<inline: true>
	0 to: machineCodeSize - 1 do:
		[:j|
		objectMemory byteAt: address + j put: (machineCode at: j)]