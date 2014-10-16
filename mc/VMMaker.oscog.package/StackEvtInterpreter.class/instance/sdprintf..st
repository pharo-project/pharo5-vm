process primitive support
sdprintf: s
	"In Android, prints the given string to the JNI debug log file."
	<api>
	<var: #s type: #'char *'>
	<doNotGenerate>