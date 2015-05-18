type inference
isSimpleType: aType
	"For the purposes of the read-before-written initializer, answer if
	 aType is simple, e.g. not a structure, and array or an opaque type."
	^aType last = $*
	  or: [#(	sqInt usqInt sqLong usqLong
			int #'unsigned int' double float
			short #'unsigned short'
			char #'unsigned char' #'signed char') includes: aType]