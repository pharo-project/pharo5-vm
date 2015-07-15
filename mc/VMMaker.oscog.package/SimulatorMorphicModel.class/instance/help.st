buttons callbacks
help
	"Open up a workspace with explanatory info in it about the StackInterpreterSimulator"
	Workspace new
		contents: self helpText;
		openLabel: self windowTitle, ' Help'.