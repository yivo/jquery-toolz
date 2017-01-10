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
