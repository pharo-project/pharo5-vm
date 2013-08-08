as yet unclassified
complementaryColourFor: aChameneosColour
   "determine the complementary colour defined as..."

   self == aChameneosColour ifTrue: [^self].
   self isBlue
      ifTrue:
         [aChameneosColour isRed
            ifTrue: [^self class yellow]
            ifFalse: [^self class red]].
   self isRed
      ifTrue:
         [aChameneosColour isBlue
            ifTrue: [^self class yellow]
            ifFalse: [^self class blue]].
   aChameneosColour isBlue
      ifTrue: [^self class red]
      ifFalse: [^self class blue]