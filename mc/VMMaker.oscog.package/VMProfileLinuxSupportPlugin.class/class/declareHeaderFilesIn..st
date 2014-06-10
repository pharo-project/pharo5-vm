translation
declareHeaderFilesIn: cg

	cg
		addHeaderFile: '<limits.h>';
		addHeaderFile: '#ifndef _GNU_SOURCE\# define _GNU_SOURCE\#endif\#include <link.h>' withCRs