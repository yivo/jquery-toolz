
/*!
 * jquery-toolz 1.0.8 | https://github.com/yivo/jquery-toolz | MIT License
 */

(function() {
  (function(factory) {
    var __root__;
    __root__ = typeof self === 'object' && self !== null && self.self === self ? self : typeof global === 'object' && global !== null && global.global === global ? global : Function('return this')();
    if (typeof define === 'function' && typeof define.amd === 'object' && define.amd !== null) {
      define(['jquery'], function($) {
        return factory(__root__, document, window, RegExp, $);
      });
    } else if (typeof module === 'object' && module !== null && typeof module.exports === 'object' && module.exports !== null) {
      factory(__root__, document, window, RegExp, require('jquery'));
    } else {
      factory(__root__, document, window, RegExp, $);
    }
  })(function(__root__, document, window, RegExp, $) {
    var base;
    (function() {
      var maskCache, maskConvert, removeClass, removeClassByMask;
      removeClass = $.fn.removeClass;
      maskCache = {};
      maskConvert = function(mask) {
        if (mask instanceof RegExp) {
          return mask;
        }
        return maskCache[mask] != null ? maskCache[mask] : maskCache[mask] = new RegExp(mask.replace(/\*/g, '\\S+'));
      };
      $.fn.removeClass = function(arg) {
        if (arguments.length > 0) {
          if (arg !== null && typeof arg === 'object' && (arg.matching != null)) {
            return removeClassByMask(this, arg.matching);
          } else {
            return removeClass.call(this, arg);
          }
        } else {
          return removeClass.call(this);
        }
      };
      return removeClassByMask = typeof DOMTokenList !== "undefined" && DOMTokenList !== null ? function(elements, mask) {
        var cls, el, i, j, l, len, re, ref;
        re = maskConvert(mask);
        for (j = 0, len = elements.length; j < len; j++) {
          el = elements[j];
          ref = el.classList;
          l = ref.length;
          i = -1;
          while (++i < l) {
            cls = ref[i];
            if (re.test(cls)) {
              el.classList.remove(cls);
              --l;
              --i;
            }
          }
        }
        return elements;
      } : function(elements, mask) {
        var cls, el, j, k, len, len1, newlist, oldlist, re;
        re = maskConvert(mask);
        for (j = 0, len = elements.length; j < len; j++) {
          el = elements[j];
          oldlist = el.className.split(' ');
          newlist = [];
          for (k = 0, len1 = oldlist.length; k < len1; k++) {
            cls = oldlist[k];
            if (!re.test(cls)) {
              newlist.push(cls);
            }
          }
          el.className = newlist.join(' ');
        }
        return elements;
      };
    })();
    (function() {
      var maskCache, maskConvert, removeAttr, removeAttrByMask;
      removeAttr = $.fn.removeAttr;
      maskCache = {};
      maskConvert = function(mask) {
        if (mask instanceof RegExp) {
          return mask;
        }
        return maskCache[mask] != null ? maskCache[mask] : maskCache[mask] = new RegExp(mask.replace(/\*/g, '\\S+'));
      };
      $.fn.removeAttr = function(arg) {
        if (arguments.length > 0) {
          if (arg !== null && typeof arg === 'object' && (arg.matching != null)) {
            return removeAttrByMask(this, arg.matching);
          } else {
            return removeAttr.call(this, arg);
          }
        } else {
          return removeAttr.call(this);
        }
      };
      return removeAttrByMask = function(elements, mask) {
        var attr, attrs, el, i, j, l, len, re;
        re = maskConvert(mask);
        for (j = 0, len = elements.length; j < len; j++) {
          el = elements[j];
          attrs = el.attributes;
          l = el.attributes.length;
          i = -1;
          while (++i < l) {
            attr = attrs[i];
            if (re.test(attr.name)) {
              --l;
              --i;
              el.removeAttribute(attr.name);
            }
          }
        }
        return elements;
      };
    })();
    (function() {
      var base, base1, css, getComputedStyle;
      getComputedStyle = window.getComputedStyle;
      css = getComputedStyle != null ? function(el, style) {
        return getComputedStyle(el)[style];
      } : function(el, style) {
        return $(el).css(style);
      };
      if ((base = $.fn).snapshotStyles == null) {
        base.snapshotStyles = function(styles) {
          var el, j, k, len, len1, ref1, style;
          ref1 = this;
          for (j = 0, len = ref1.length; j < len; j++) {
            el = ref1[j];
            for (k = 0, len1 = styles.length; k < len1; k++) {
              style = styles[k];
              el.style[style] = css(el, style);
            }
          }
          return this;
        };
      }
      return (base1 = $.fn).releaseSnapshot != null ? base1.releaseSnapshot : base1.releaseSnapshot = function(styles) {
        var el, j, k, len, len1, ref1, style;
        ref1 = this;
        for (j = 0, len = ref1.length; j < len; j++) {
          el = ref1[j];
          el.offsetHeight;
          for (k = 0, len1 = styles.length; k < len1; k++) {
            style = styles[k];
            el.style[style] = '';
          }
        }
        return this;
      };
    })();
    if ($.prefix == null) {
      $.prefix = function(property) {
        return ["-moz-" + property, "-o-" + property, "-ms-" + property, "-webkit-" + property, property];
      };
    }
    if ((base = $.fn).tag == null) {
      base.tag = function() {
        var ref1;
        return (ref1 = this[0]) != null ? ref1.tagName.toLowerCase() : void 0;
      };
    }
    (function() {
      var base1;
      if ($.ff == null) {
        $.ff = document.querySelector != null ? function(selector) {
          return $(document.querySelector(selector));
        } : $;
      }
      return (base1 = $.fn).ff != null ? base1.ff : base1.ff = document.querySelector != null ? function(selector) {
        var ref1;
        return $((ref1 = this[0]) != null ? ref1.querySelector(selector) : void 0);
      } : $.fn.find;
    })();
    $.fn.truth = function(attribute) {
      var value;
      return ((value = this.attr(attribute)) != null) && (value !== false && value !== 'false');
    };
    $.fn.hasAttr = function(attribute) {
      var ref1;
      return !!((ref1 = this[0]) != null ? ref1.hasAttribute(attribute) : void 0);
    };
    $.postJSON = function(url, data, options) {
      return $.ajax(url, $.extend(options != null ? options : {}, {
        data: JSON.stringify(data != null ? data : {}),
        contentType: 'application/json',
        type: 'POST'
      }));
    };
    $.putJSON = function(url, data, options) {
      return $.ajax(url, $.extend(options != null ? options : {}, {
        data: JSON.stringify(data != null ? data : {}),
        contentType: 'application/json',
        type: 'PUT'
      }));
    };
    $.deleteJSON = function(url, data, options) {
      return $.ajax(url, $.extend(options != null ? options : {}, {
        data: JSON.stringify(data != null ? data : {}),
        contentType: 'application/json',
        type: 'DELETE'
      }));
    };
  });

}).call(this);
