C library simulation
str: aString cat: bString
	<doNotGenerate>
	"implementation of strcat(3)"
	^(self asString: aString), (self asString: bString)