menus
release
	vmMaker ifNotNil: [ vmMaker removeDependent: self ].
	super release.