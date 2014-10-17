private
newMark
	"Select a previously unused mark value.

	 Details: We just keep incrementing. If necessary, the counter will
	 turn into a LargePositiveInteger. In that case, it will be a bit
	 slower to compute the next mark but the algorithms will all behave
	 correctly. We reserve the value '0' to mean 'unmarked'. Thus, this
	 generator starts at '1' and will never produce '0' as a mark value."

	^currentMark := currentMark + 1