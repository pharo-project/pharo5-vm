tests
callTrapPerformance: n
	"Call a function that is out-of-range.  Ensure the call is trapped."
	"self new testCallTrap"
	| memory |
	 "The address is out of range of memory every which way (whether relative or absolute and whether big-endian or little."
	memory := ByteArray new: 1024.
	memory replaceFrom: 1 to: 5 with: { self processor callOpcode. 0. 16r80. 16r80. 0. } asByteArray.
	self processor
			eip: 0;
			esp: (memory size - 4). "Room for return address"
	1 to: n do:
		[:ign|
		[self processor singleStepIn: memory]
			on: ProcessorSimulationTrap
			do: [:ex|]].

	"QSystemProfiler spyOn: [BochsIA32AlienTests new callTrapPerformance: 1024*128]"
	"Time millisecondsToRun: [BochsIA32AlienTests new callTrapPerformance: 1024*128] 2463"
	"Time millisecondsToRun: [1 to: 1024*1024*64 do: [:ign| nil yourself]] 636"
	"Time millisecondsToRun: [1 to: 1024*1024*64 do: [:ign| nil perform: #ifNotNilDo: with: nil]] 3639"
	"Time millisecondsToRun: [1 to: 1024*1024*64 do: [:ign| nil perform: #ifNotNilDo:ifNil: with: nil with: nil]] 12401"