thirdparty libs
addThirdpartyLibrary: libName
	| libs lib |
	
	libs := self thirdpartyLibs.
	
	lib :=  libs 
		detect: [:each | each canonicalName = libName ] 
		ifNone: [ nil ].
		
	lib ifNil: [ 
		lib := CMThirdpartyLibrary named: libName config: self.
		"add dependencies first, so thirpartyLibs collection will be naturally dependency sorted"
		lib dependencies do: [:dep | self addThirdpartyLibrary: dep ].
		libs add: lib ].

	^ lib