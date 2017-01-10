{getComputedStyle} = window

css = if getComputedStyle?
  (el, style) -> getComputedStyle(el)[style]
else
  (el, style) -> $(el).css(style)

$.fn.snapshotStyles ?= (styles) ->
  for el in this
    for style in styles
      el.style[style] = css(el, style)
  this

$.fn.releaseSnapshot ?= (styles) ->
  for el in this
    el.offsetHeight
    for style in styles
      el.style[style] = ''
  this
