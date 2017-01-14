generate sources
set64BitVM: boolean
"do I build a 64bit VM or not?"
	boolean ifTrue:[vmMaker for64BitVM] ifFalse:[vmMaker for32BitVM].
	self changed: #sourcePathText