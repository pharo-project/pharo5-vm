object access
obsoleteDontUseThisFetchWord: fieldIndex ofObject: oop
"fetchWord:ofObject: is rescinded as of VMMaker 3.8 64bit VM. This is a placeholder to sit in the sqVirtualMachine structure to support older plugins for a while"
	self halt: 'deprecated method'