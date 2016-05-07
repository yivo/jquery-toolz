(function() {
  (function(factory) {
    var __module__, root;
    root = typeof self === 'object' && self !== null && self.self === self ? self : typeof global === 'object' && global !== null && global.global === global ? global : void 0;
    if (typeof define === 'function' && typeof define.amd === 'object' && define.amd !== null) {
      __module__ = factory(root);
      define(function() {
        return __module__;
      });
    } else if (typeof module === 'object' && module !== null && typeof module.exports === 'object' && module.exports !== null) {
      factory(root);
    } else {
      factory(root);
    }
  })(function(__root__) {
    var base, base1, base2, base3, getComputedStyle;
    if ((base = $.fn).tag == null) {
      base.tag = function() {
        var ref1;
        return (ref1 = this[0]) != null ? ref1.tagName.toLowerCase() : void 0;
      };
    }
    if ((base1 = $.fn).removeClassByMask == null) {
      base1.removeClassByMask = (function() {
        var cache, convert;
        cache = {};
        convert = function(mask) {
          return cache[mask] != null ? cache[mask] : cache[mask] = new RegExp(mask.replace(/\*/g, '\\S+'));
        };
        if (typeof DOMTokenList !== "undefined" && DOMTokenList !== null) {
          return function(mask) {
            var cls, el, i, j, l, len, re, ref;
            re = convert(mask);
            for (j = 0, len = this.length; j < len; j++) {
              el = this[j];
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
            return this;
          };
        } else {
          return function(mask) {
            var cls, el, j, k, len, len1, newlist, oldlist, re;
            re = convert(mask);
            for (j = 0, len = this.length; j < len; j++) {
              el = this[j];
              oldlist = el.className.split(' ');
              newlist = null;
              for (k = 0, len1 = oldlist.length; k < len1; k++) {
                cls = oldlist[k];
                if (!re.test(cls)) {
                  (newlist != null ? newlist : newlist = []).push(cls);
                }
              }
              el.className = newlist != null ? newlist.join(' ') : '';
            }
            return this;
          };
        }
      })();
    }
    getComputedStyle = (typeof window !== "undefined" && window !== null ? window : this).getComputedStyle;
    if ((base2 = $.fn).snapshotStyles == null) {
      base2.snapshotStyles = getComputedStyle != null ? function(styles) {
        var el, i, j, k, len, len1, style;
        for (j = 0, len = this.length; j < len; j++) {
          el = this[j];
          for (i = k = 0, len1 = styles.length; k < len1; i = ++k) {
            style = styles[i];
            el.style[style] = getComputedStyle(el)[style];
          }
        }
        return this;
      } : function(styles) {
        var el, i, j, k, len, len1, style;
        for (j = 0, len = this.length; j < len; j++) {
          el = this[j];
          for (i = k = 0, len1 = styles.length; k < len1; i = ++k) {
            style = styles[i];
            el.style[style] = el.css(style);
          }
        }
        return this;
      };
    }
    if ((base3 = $.fn).releaseSnapshot == null) {
      base3.releaseSnapshot = function(styles) {
        var el, i, j, k, len, len1, style;
        for (j = 0, len = this.length; j < len; j++) {
          el = this[j];
          el.offsetHeight;
          for (i = k = 0, len1 = styles.length; k < len1; i = ++k) {
            style = styles[i];
            el.style[style] = '';
          }
        }
        return this;
      };
    }
    if ($.prefix == null) {
      $.prefix = function(property) {
        return ["-moz-" + property, "-o-" + property, "-ms-" + property, "-webkit-" + property, property];
      };
    }
  });

}).call(this);
