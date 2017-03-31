$.fn.truth = (attribute) ->
  @attr(attribute) not in [false, 'false']
