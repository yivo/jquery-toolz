$.fn.truth = (attribute) ->
  (value = @attr(attribute))? and value not in [false, 'false']
