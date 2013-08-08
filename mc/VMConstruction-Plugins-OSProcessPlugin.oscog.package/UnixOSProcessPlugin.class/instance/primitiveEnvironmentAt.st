primitives - OS process access
primitiveEnvironmentAt
	"Answer a string containing the OS process environment string at index (an Integer)
	in the environment list."

	| index envVec p envCnt sPtr s |
	<export: true>
	<var: 'p' declareC: 'char **p'>
	<var: 'sPtr' declareC: 'char *sPtr'>
	<var: 'envVec' declareC: 'extern char **envVec'>
	"Count number of environment variables."
	p := envVec.
	envCnt := 0.
	self cCode: 'while (*p++) envCnt++' inSmalltalk: [envCnt := 0].
	index := interpreterProxy stackIntegerValue: 0.
	((index > envCnt) | (index < 1))
	ifTrue:
		[interpreterProxy pop: 2; push: interpreterProxy nilObject]
	ifFalse:
		[sPtr := self cCode: 'envVec[index - 1]' inSmalltalk: [''].
		s := self stringFromCString: sPtr.
		interpreterProxy pop: 2; push: s]
