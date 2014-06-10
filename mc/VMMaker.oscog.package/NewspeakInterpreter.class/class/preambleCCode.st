translation
preambleCCode
	^	
'void printCallStack(void);

/* Disable Intel compiler inlining of warning which is used for breakpoints */
#pragma auto_inline off
void
warning(char *s) { /* Print an error message but don''t exit. */
	printf("\n%s\n", s);
}
#pragma auto_inline on

void
invalidCompactClassError(char *s) { /* Print a compact class index error message and exit. */
	static sqInt printingStack = true; /* not running at this point */

	printf("\nClass %s does not have the required compact class index\n", s);
	exit(-1);
}

/*
 * Define sigsetjmp and siglongjmp to be the most minimal setjmp/longjmp available on the platform.
 */
#if WIN32
# define sigsetjmp(jb,ssmf) setjmp(jb)
# define siglongjmp(jb,v) longjmp(jb,v)
#else
# define sigsetjmp(jb,ssmf) _setjmp(jb)
# define siglongjmp(jb,v) _longjmp(jb,v)
#endif
'