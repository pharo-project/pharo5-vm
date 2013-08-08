translation
declareCVarsIn: cg
	"Define FILEHANDLETYPE. The #include <unistd.h> is completely unnecessary, but
	serves as a way to kludge the #define into the header."

	cg addHeaderFile: '<unistd.h>
#define FILEHANDLETYPE FILE *  /* the type of low level stream to be used in a struct SQFile */'
