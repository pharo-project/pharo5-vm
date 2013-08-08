plugin extra rules
extraPluginSettings: maker
	super extraPluginSettings: maker.  
	maker set: #linkFlags toString: '${linkFlags} -m32'
