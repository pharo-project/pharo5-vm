I am a shared pool for basic constants upon which the VM as a whole depends.

self ensureClassPool.
self classPool declare: #BytesPerWord from: VMSqueakV3ObjectRepresentationConstants classPool.
self classPool declare: #BaseHeaderSize from: VMSqueakV3ObjectRepresentationConstants classPool
(ObjectMemory classPool keys select: [:k| k beginsWith: 'Byte']) do:
	[:k| self classPool declare: k from: ObjectMemory classPool]