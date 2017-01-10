do ->
  $.ff ?= if document.querySelector?
    (selector) -> $(document.querySelector(selector))
  else
    $
  
  $.fn.ff ?= if document.querySelector?
    (selector) -> $(this[0]?.querySelector(selector))
  else
    $.fn.find
