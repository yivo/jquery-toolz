((factory) ->

  # Browser and WebWorker
  root = if typeof self is 'object' and self isnt null and self.self is self
    self

  # Server
  else if typeof global is 'object' and global isnt null and global.global is global
    global

  # AMD
  if typeof define is 'function' and typeof define.amd is 'object' and define.amd isnt null
    define ['jquery', 'exports'], ($) ->
      factory(root, document, window, RegExp, $)

  # CommonJS
  else if typeof module is 'object' and module isnt null and
          typeof module.exports is 'object' and module.exports isnt null
    factory(root, document, window, RegExp, require('jquery'))

  # Browser and the rest
  else
    factory(root, document, window, RegExp, root.$)

  # No return value
  return

)((__root__, document, window, RegExp, $) ->
  # Usage: 
  #   * $el.removeClass(matching: 'example-*')
  #   * $el.removeClass(matching: /something/)
  do ->
    removeClass = $.fn.removeClass
    maskCache   = {}
    maskConvert = (mask) ->
      return mask if mask instanceof RegExp
      maskCache[mask] ?= new RegExp(mask.replace(/\*/g, '\\S+'))
      
    $.fn.removeClass = (arg) ->
      if arguments.length > 0
        if arg isnt null and typeof arg is 'object' and arg.matching?
          removeClassByMask(this, arg.matching)
        else
          removeClass.call(this, arg)
      else
        removeClass.call(this)
          
    removeClassByMask =
      if DOMTokenList?
        (elements, mask) ->
          re = maskConvert(mask)
          for el in elements
            ref = el.classList
            l   = ref.length
            i   = -1
            while ++i < l
              cls = ref[i]
              if re.test(cls)
                el.classList.remove(cls)
                --l
                --i
          elements
      else
        (elements, mask) ->
          re = maskConvert(mask)
          for el in elements
            oldlist = el.className.split(' ')
            newlist = []
            for cls in oldlist when not re.test(cls)
              newlist.push(cls)
            el.className = newlist.join(' ')
          elements
  
  do ->
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
  
  $.prefix ?= (property) ->
    ["-moz-#{property}", "-o-#{property}", "-ms-#{property}", "-webkit-#{property}", property]
  
  $.fn.tag ?= ->
    this[0]?.tagName.toLowerCase()
  
  do ->
    $.ff ?= if document.querySelector?
      (selector) -> $(document.querySelector(selector))
    else
      $
    
    $.fn.ff ?= if document.querySelector?
      (selector) -> $(this[0]?.querySelector(selector))
    else
      $.fn.find
  # No global variable export
  return
)