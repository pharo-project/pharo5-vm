translation
moduleNameAndVersion
	"Answer the receiver's module name and version info that is used for the plugin's C code. The default is to append the code generation date, but any useful text is ok (keep it short)"

	^ self moduleName, Character space asString, self version, Character space asString, Date today asString