I am a shared pool for the constants that define object layout and well-known objects shared between the object memories (e.g. ObjectMemory, NewObjectMemory), the interpreters (e.g. StackInterpreter, CoInterpreter) and the object representations (e.g. ObjectRepresentationForSqueakV3).

self classPool declare: #Foo from: StackInterpreter classPool

(ObjectMemory classPool keys select: [:k| (k beginsWith: 'Class') and: [(k endsWith: 'Index') not]]) do:
	[:k| self classPool declare: k from: ObjectMemory classPool]