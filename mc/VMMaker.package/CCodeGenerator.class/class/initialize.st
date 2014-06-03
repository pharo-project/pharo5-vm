class initialization
initialize
	"CCodeGenerator initialize"

	UseRightShiftForDivide := true.
		"If UseRightShiftForDivide is true, the translator will generate a right-shift when it encounters a division by a constant that is a small power of two. For example, 'x / 8' will generate '((int) x >> 3)'. The coercion to int is done to make it clear that the C compiler should generate a signed shift."
		"Note: The Kernighan and Ritchie 2nd Edition C manual, p. 49, leaves the semantics of right-shifting a negative number open to the discretion of the compiler implementor. However, it strongly suggests that most compilers should generate an arithmetic right shift (i.e., shifting in the sign bit), which is the same as dividing by a power of two. If your compiler does not generate or simulate an arithmetic shift, then make this class variable false and re-translate."

	NoRegParmsInAssertVMs := true
		"If NoRegParmsInAssertVMs is true the generator spits out an attribute turning off register parameters for static functions in the Assert and Debug VMs which makes debugging easier, since all functions can be safely called from gdb.  One might hope that -mregparm=0 would work but at least on Mac OS X's gcc 4.2.1 it does not and hence we have to use a per funciton attribute.  Sigh..."