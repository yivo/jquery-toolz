$.prefix ?= (property) ->
  ["-moz-#{property}", "-o-#{property}", "-ms-#{property}", "-webkit-#{property}", property]
