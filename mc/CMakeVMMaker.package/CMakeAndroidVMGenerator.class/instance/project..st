submakefile creation
project: aProjectName  
	self puts: '# Build ', aProjectName.
	self puts: 'include $(CLEAR_VARS)'.
	"self puts: 'LOCAL_PATH := $(TOP_PATH)/', aProjectName."
	self puts: 'LOCAL_MODULE :=',aProjectName
	