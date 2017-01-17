translation
declareHeaderFilesIn: cg

	cg
		addHeaderFile: '<limits.h>';
		addHeaderFile: '#ifdef __OpenBSD__\#include <dlfcn.h>\#endif' withCRs;
		addHeaderFile: '#ifndef _GNU_SOURCE\# define _GNU_SOURCE\#endif\#include <link.h>' withCRs;
		addHeaderFile: '#ifndef RTLD_NODELETE\# define RTLD_NODELETE 0\#endif' withCRs