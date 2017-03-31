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
