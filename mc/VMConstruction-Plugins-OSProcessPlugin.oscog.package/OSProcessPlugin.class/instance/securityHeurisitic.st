private - security
securityHeurisitic
	"Answer 0 to permit full access to OSProcess functions, or 1 if access should be
	restricted for dangerous functions. The rules are:
		- If the security plugin is not present, grant full access
		- If the security plugin can be loaded, restrict access unless user has all
		  of secCanWriteImage, secHasFileAccess and secHasSocketAccess"

	"FIXME: This function has not been tested. -dtl"

	| sCWIfn sHFAfn sHSAfn canWriteImage hasFileAccess hasSocketAccess |
	"If the security plugin can be loaded, use it to check. If not, assume it's ok"

	<var: 'sCWIfn' declareC: 'void (*sCWIfn)(void)'>
	<var: 'sHFAfn' declareC: 'void (*sHFAfn)(void)'>
	<var: 'sHSAfn' declareC: 'void (*sHSAfn)(void)'>

	sCWIfn := interpreterProxy ioLoadFunction: 'secCanWriteImage' From: 'SecurityPlugin'.
	(sCWIfn = 0) ifTrue: [^ 0 "Cannot find plugin, so grant default full access"].
	canWriteImage := self cCode: ' ((int (*) (void)) sCWIfn)()'
				inSmalltalk: [1].
	sHFAfn := interpreterProxy ioLoadFunction: 'secHasFileAccess' From: 'SecurityPlugin'.
	(sHFAfn = 0) ifTrue: [^ 0 "Cannot find plugin, so grant default full access"].
	hasFileAccess := self cCode: ' ((int (*) (void)) sHFAfn)()'
				inSmalltalk: [1].
	sHSAfn := interpreterProxy ioLoadFunction: 'secHasSocketAccess' From: 'SecurityPlugin'.
	(sHSAfn = 0) ifTrue: [^ 0 "Cannot find plugin, so grant default full access"].
	hasSocketAccess := self cCode: ' ((int (*) (void)) sHSAfn)()'
				inSmalltalk: [1].
	((canWriteImage and: [hasFileAccess]) and: [hasSocketAccess])
		ifTrue: [^ 0 "Grant full access"]
		ifFalse: [^ 1 "Restricted access"]
