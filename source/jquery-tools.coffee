$.fn.tag ?= ->
  this[0]?.tagName.toLowerCase()

# TODO Better, shorter name
$.fn.removeClassByMask ?= do ->
  cache   = {}
  convert = (mask) -> cache[mask] ?= new RegExp(mask.replace(/\*/g, '\\S+'))
  if DOMTokenList?
    (mask) ->
      re = convert(mask)
      for el in this
        ref = el.classList
        l   = ref.length
        i   = -1
        while ++i < l
          cls = ref[i]
          if re.test(cls)
            el.classList.remove(cls)
            --l
            --i
      this
  else
    (mask) ->
      re = convert(mask)
      for el in this
        oldlist = el.className.split(' ')
        newlist = null
        for cls in oldlist when not re.test(cls)
          (newlist ?= []).push(cls)
        el.className = if newlist? then newlist.join(' ') else ''
      this

{getComputedStyle} = window ? this

$.fn.snapshotStyles ?= if getComputedStyle?
  (styles) ->
    for el in this
      for style, i in styles
        el.style[style] = getComputedStyle(el)[style]
    this
else
  (styles) ->
    for el in this
      for style, i in styles
        el.style[style] = el.css(style)
    this

$.fn.releaseSnapshot ?= (styles) ->
  for el in this
    el.offsetHeight
    for style, i in styles
      el.style[style] = ''
  this

$.prefix ?= (property) ->
  ["-moz-#{property}", "-o-#{property}", "-ms-#{property}", "-webkit-#{property}", property]