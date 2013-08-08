interpreter shell
undoFetchNextBytecode
	"Backup the ip when it has been incremented to fetch the next bytecode."

	localIP := localIP - 1