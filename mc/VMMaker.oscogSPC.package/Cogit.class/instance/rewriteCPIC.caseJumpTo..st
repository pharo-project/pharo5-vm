in-line cacheing
rewriteCPIC: cPIC caseJumpTo: target 
	"adding a new CPIC case, or making an MNU CPIC, requires altering the jump that takes us to the first case to be used"
	<inline: true>
	backEnd rewriteCPICJumpAt: cPIC asInteger + firstCPICCaseOffset - backEnd jumpLongByteSize - backEnd loadLiteralByteSize target: target