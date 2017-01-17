accessing
machineCodeAt: anOffset put: aWord
	"add aWord to machineCode, with little endian"
	<inline: true>
	machineCode at: anOffset // 4 put: aWord