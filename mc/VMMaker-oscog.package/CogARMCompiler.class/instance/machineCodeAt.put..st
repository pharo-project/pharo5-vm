accessing
machineCodeAt: anOffset put: aWord
	"add aWord to machineCode, with little endian"
	<inline: true>
	machineCode
		at: anOffset + 3 put: (16rFF bitAnd: aWord >> 24);
		at: anOffset + 2 put: (16rFF bitAnd: aWord >> 16);
		at: anOffset + 1 put: (16rFF bitAnd: aWord >> 8);
		at: anOffset"+ 0"put: (16rFF bitAnd: aWord">> 0")