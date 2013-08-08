translation
declareCVarsIn: cg

	"Additional declarations are done in my subclasses. This permits a meaningful
	module identification string to be written with the name of the actual subclass
	being generated."

	cg addHeaderFile: '<sys/types.h>'.
	cg addHeaderFile: '<sys/time.h>'.
	cg addHeaderFile: '<sys/stat.h>'.	"For stat(2) call in primitiveFileProtectionMask"
	cg addHeaderFile: '<sys/wait.h>'.
	cg addHeaderFile: '<signal.h>'.
	cg addHeaderFile: '<unistd.h>'.
	cg addHeaderFile: '<fcntl.h>'.
	cg addHeaderFile: '<pthread.h>'.
	cg addHeaderFile: '<errno.h>'.
	cg addHeaderFile: '"config.h"'.
	cg addHeaderFile: '"sqaio.h"'.
	cg addConstantForBinding: 'FILEHANDLETYPE' -> 'FILE *  /* the type of low level stream to be used in a struct SQFile */'.
	cg var: 'sigHandlers' declareC: 'void *sigHandlers[NSIG]'.
	cg var: 'originalSigHandlers' declareC: 'void *originalSigHandlers[NSIG]'.
	cg var: 'semaIndices' declareC: 'unsigned char semaIndices[NSIG]'.
	cg var: 'exitFunction' declareC: 'void (*exitFunction)(void) = NULL'.
	cg var: 'sigNumToSend' declareC: 'int sigNumToSend = SIGTERM'.
	cg var: 'pidArray' declareC: 'pid_t *pidArray = NULL'.
	cg var: 'vmThread' type: 'pthread_t'

