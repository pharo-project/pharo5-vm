accessing
machineCodeAt: anOffset
	"read aWord from machineCode, with little endian"
	<inline: true>
	^((machineCode at: anOffset"+0")"<< 0" bitOr: (machineCode at: anOffset + 1) << 8) 
		bitOr: ((machineCode at: anOffset + 2) << 16 bitOr: (machineCode at: anOffset + 3) << 24)
