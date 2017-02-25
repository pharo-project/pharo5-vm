class initialization
initialize
	"CCodeGenerator initialize"

	NoRegParmsInAssertVMs := true
		"If NoRegParmsInAssertVMs is true the generator spits out an attribute turning off register parameters for static functions in the Assert and Debug VMs which makes debugging easier, since all functions can be safely called from gdb.  One might hope that -mregparm=0 would work but at least on Mac OS X's gcc 4.2.1 it does not and hence we have to use a per funciton attribute.  Sigh..."