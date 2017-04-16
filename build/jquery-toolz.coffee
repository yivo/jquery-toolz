###!
# jquery-toolz 1.0.5 | https://github.com/yivo/jquery-toolz | MIT License
###

((factory) ->

  __root__ = 
    # The root object for Browser or Web Worker
    if typeof self is 'object' and self isnt null and self.self is self
      self

    # The root object for Server-side JavaScript Runtime
    else if typeof global is 'object' and global isnt null and global.global is global
      global

    else
      Function('return this')()

  # Asynchronous Module Definition (AMD)
  if typeof define is 'function' and typeof define.amd is 'object' and define.amd isnt null
    define ['jquery'], ($) ->
      factory(__root__, document, window, RegExp, $)

  # Server-side JavaScript Runtime compatible with CommonJS Module Spec
  else if typeof module is 'object' and module isnt null and typeof module.exports is 'object' and module.exports isnt null
    factory(__root__, document, window, RegExp, require('jquery'))

  # Browser, Web Worker and the rest
  else
    factory(__root__, document, window, RegExp, $)

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
  
  $.fn.truth = (attribute) ->
    (value = @attr(attribute))? and value not in [false, 'false']
  
  $.fn.hasAttr = (attribute) ->
    !!this[0]?.hasAttribute(attribute)
  
  $.postJSON = (url, data, options) ->
    $.ajax url, $.extend options ? {},
      data:        JSON.stringify(data ? {})
      contentType: 'application/json'
      type:        'POST'
  
  $.putJSON = (url, data, options) ->
    $.ajax url, $.extend options ? {},
      data:        JSON.stringify(data ? {})
      contentType: 'application/json'
      type:        'PUT'
  
  $.deleteJSON = (url, data, options) ->
    $.ajax url, $.extend options ? {},
      data:        JSON.stringify(data ? {})
      contentType: 'application/json'
      type:        'DELETE'
  # Nothing exported
  return
)