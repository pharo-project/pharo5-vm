drivers
addDriver: name sources: aSources generator: cmakeGen externalLibs: extLibs
			
			cmakeGen	project: name.
			
			cmakeGen setTargetPlatform: self architecture. 
			
			self preferredIncludes do: [ :each | 
				cmakeGen includeDirectories: each ].
			
			self compilerFlags do:[:each | 
				cmakeGen addDefinitions: each].
			
			self linkFlags do: [:each |  
				cmakeGen addExternalLibrary: each.].
			
			extLibs do: [:each |  
				cmakeGen addExternalLibrary: each.].
			
			cmakeGen addDependency: self virtualMachineName.
			 
			aSources do: [:each |
				cmakeGen addRawSource: each].
			
			cmakeGen includeAsSharedLib.
	