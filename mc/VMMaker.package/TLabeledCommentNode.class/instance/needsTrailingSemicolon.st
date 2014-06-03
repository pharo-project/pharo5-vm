testing
needsTrailingSemicolon
	"Answer if, when emitted as a statement (in particular in a TStmtList), the
	 receiver needs a trailing semicolon.  Comments do not.  You'd think that
	 labels do not, but we put them at the end of blocks where there needs
	 to be a null statement following the label and before the end of block."
	^self isComment not