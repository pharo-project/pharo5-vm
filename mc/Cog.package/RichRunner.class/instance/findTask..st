private
findTask: identity 
    | t |
    t := taskTable at: identity.
    t ifNil: [self error: 'findTask failed'].
    ^ t