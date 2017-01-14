accessing
machineCodeAt: anOffset
	"read aWord from machineCode, with little endian"
	<inline: true>
	^machineCode at: anOffset // 4