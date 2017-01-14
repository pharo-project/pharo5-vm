ipv6 primitives
primitiveResolverGetAddressInfoHost: hostName service: servName flags: flags family: family type: type protocol: protocol

	| hostSize servSize |
	self primitive: 'primitiveResolverGetAddressInfo'
		parameters: #(String String SmallInteger SmallInteger SmallInteger SmallInteger).
	interpreterProxy failed
		ifFalse:
			[hostSize := interpreterProxy byteSizeOf: hostName cPtrAsOop.
			 servSize := interpreterProxy byteSizeOf: servName cPtrAsOop.
			 self
			 	sqResolverGetAddressInfoHost: hostName Size: hostSize Service: servName Size: servSize
					Flags: flags Family: family Type: type Protocol: protocol]