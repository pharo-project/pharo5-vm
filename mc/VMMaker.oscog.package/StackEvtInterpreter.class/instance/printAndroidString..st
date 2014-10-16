process primitive support
printAndroidString: aInt
	"In Android, prints the given string to the JNI debug log file."
	<api>
	<var: #aInt type: #'char *'>
	<doNotGenerate>