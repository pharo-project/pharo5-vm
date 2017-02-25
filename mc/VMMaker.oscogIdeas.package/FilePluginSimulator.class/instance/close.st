initialize-release
close  "close any files that ST may have opened"
	openFiles do: [:f | f close]