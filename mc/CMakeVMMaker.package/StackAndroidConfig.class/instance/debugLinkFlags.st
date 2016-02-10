utils - linking
debugLinkFlags
	^#(
	'-Wl,-wrap=perror,-wrap=error,-wrap=fprintf,-wrap=printf,-wrap=fputs,-wrap=putchar,-wrap=fflush,-wrap=warning,-wrap=puts'
	)