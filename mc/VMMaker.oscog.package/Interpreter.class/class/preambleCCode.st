translation
preambleCCode
	^	
'void printCallStack(void);

/* Disable Intel compiler inlining of error & warning which are used for breakpoints */
#pragma auto_inline(off)

void
warning(char *s) { /* Print an error message but don''t exit. */
	static sqInt printingStack = false;

	printf("\n%s\n", s);
}
#pragma auto_inline(on)

void
invalidCompactClassError(char *s) { /* Print a compact class index error message and exit. */
	static sqInt printingStack = true; /* not running at this point */

	printf("\nClass %s does not have the required compact class index\n", s);
	exit(-1);
}
'