private - security
sandboxSecurity
	"Answer 1 if running in secure mode, else 0. The osprocessSandboxSecurity
	variable is initialized to -1. On the first call to this method, set its value to
	either 0 (user has full access to the plugin) or 1 (user is not permitted to do
	dangerous things)."

	(osprocessSandboxSecurity < 0) ifTrue: [osprocessSandboxSecurity := self securityHeurisitic].
	^ osprocessSandboxSecurity
