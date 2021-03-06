// Generated by Haxe 4.0.5
(function ($global) { "use strict";
var $estr = function() { return js_Boot.__string_rec(this,''); },$hxEnums = $hxEnums || {},$_;
function $extend(from, fields) {
	var proto = Object.create(from);
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var HxOverrides = function() { };
HxOverrides.__name__ = true;
HxOverrides.cca = function(s,index) {
	var x = s.charCodeAt(index);
	if(x != x) {
		return undefined;
	}
	return x;
};
HxOverrides.substr = function(s,pos,len) {
	if(len == null) {
		len = s.length;
	} else if(len < 0) {
		if(pos == 0) {
			len = s.length + len;
		} else {
			return "";
		}
	}
	return s.substr(pos,len);
};
Math.__name__ = true;
var haxe_Resource = function() { };
haxe_Resource.__name__ = true;
haxe_Resource.getString = function(name) {
	var _g = 0;
	var _g1 = haxe_Resource.content;
	while(_g < _g1.length) {
		var x = _g1[_g];
		++_g;
		if(x.name == name) {
			if(x.str != null) {
				return x.str;
			}
			var b = haxe_crypto_Base64.decode(x.data);
			return b.toString();
		}
	}
	return null;
};
var haxe_io_Bytes = function(data) {
	this.length = data.byteLength;
	this.b = new Uint8Array(data);
	this.b.bufferValue = data;
	data.hxBytes = this;
	data.bytes = this.b;
};
haxe_io_Bytes.__name__ = true;
haxe_io_Bytes.ofString = function(s,encoding) {
	if(encoding == haxe_io_Encoding.RawNative) {
		var buf = new Uint8Array(s.length << 1);
		var _g = 0;
		var _g1 = s.length;
		while(_g < _g1) {
			var i = _g++;
			var c = s.charCodeAt(i);
			buf[i << 1] = c & 255;
			buf[i << 1 | 1] = c >> 8;
		}
		return new haxe_io_Bytes(buf.buffer);
	}
	var a = [];
	var i1 = 0;
	while(i1 < s.length) {
		var c1 = s.charCodeAt(i1++);
		if(55296 <= c1 && c1 <= 56319) {
			c1 = c1 - 55232 << 10 | s.charCodeAt(i1++) & 1023;
		}
		if(c1 <= 127) {
			a.push(c1);
		} else if(c1 <= 2047) {
			a.push(192 | c1 >> 6);
			a.push(128 | c1 & 63);
		} else if(c1 <= 65535) {
			a.push(224 | c1 >> 12);
			a.push(128 | c1 >> 6 & 63);
			a.push(128 | c1 & 63);
		} else {
			a.push(240 | c1 >> 18);
			a.push(128 | c1 >> 12 & 63);
			a.push(128 | c1 >> 6 & 63);
			a.push(128 | c1 & 63);
		}
	}
	return new haxe_io_Bytes(new Uint8Array(a).buffer);
};
haxe_io_Bytes.prototype = {
	getString: function(pos,len,encoding) {
		if(pos < 0 || len < 0 || pos + len > this.length) {
			throw new js__$Boot_HaxeError(haxe_io_Error.OutsideBounds);
		}
		if(encoding == null) {
			encoding = haxe_io_Encoding.UTF8;
		}
		var s = "";
		var b = this.b;
		var i = pos;
		var max = pos + len;
		switch(encoding._hx_index) {
		case 0:
			var debug = pos > 0;
			while(i < max) {
				var c = b[i++];
				if(c < 128) {
					if(c == 0) {
						break;
					}
					s += String.fromCodePoint(c);
				} else if(c < 224) {
					var code = (c & 63) << 6 | b[i++] & 127;
					s += String.fromCodePoint(code);
				} else if(c < 240) {
					var c2 = b[i++];
					var code1 = (c & 31) << 12 | (c2 & 127) << 6 | b[i++] & 127;
					s += String.fromCodePoint(code1);
				} else {
					var c21 = b[i++];
					var c3 = b[i++];
					var u = (c & 15) << 18 | (c21 & 127) << 12 | (c3 & 127) << 6 | b[i++] & 127;
					s += String.fromCodePoint(u);
				}
			}
			break;
		case 1:
			while(i < max) {
				var c1 = b[i++] | b[i++] << 8;
				s += String.fromCodePoint(c1);
			}
			break;
		}
		return s;
	}
	,toString: function() {
		return this.getString(0,this.length);
	}
};
var haxe_io_Encoding = $hxEnums["haxe.io.Encoding"] = { __ename__ : true, __constructs__ : ["UTF8","RawNative"]
	,UTF8: {_hx_index:0,__enum__:"haxe.io.Encoding",toString:$estr}
	,RawNative: {_hx_index:1,__enum__:"haxe.io.Encoding",toString:$estr}
};
var haxe_crypto_Base64 = function() { };
haxe_crypto_Base64.__name__ = true;
haxe_crypto_Base64.decode = function(str,complement) {
	if(complement == null) {
		complement = true;
	}
	if(complement) {
		while(HxOverrides.cca(str,str.length - 1) == 61) str = HxOverrides.substr(str,0,-1);
	}
	return new haxe_crypto_BaseCode(haxe_crypto_Base64.BYTES).decodeBytes(haxe_io_Bytes.ofString(str));
};
var haxe_crypto_BaseCode = function(base) {
	var len = base.length;
	var nbits = 1;
	while(len > 1 << nbits) ++nbits;
	if(nbits > 8 || len != 1 << nbits) {
		throw new js__$Boot_HaxeError("BaseCode : base length must be a power of two.");
	}
	this.base = base;
	this.nbits = nbits;
};
haxe_crypto_BaseCode.__name__ = true;
haxe_crypto_BaseCode.prototype = {
	initTable: function() {
		var tbl = [];
		var _g = 0;
		while(_g < 256) {
			var i = _g++;
			tbl[i] = -1;
		}
		var _g1 = 0;
		var _g2 = this.base.length;
		while(_g1 < _g2) {
			var i1 = _g1++;
			tbl[this.base.b[i1]] = i1;
		}
		this.tbl = tbl;
	}
	,decodeBytes: function(b) {
		var nbits = this.nbits;
		var base = this.base;
		if(this.tbl == null) {
			this.initTable();
		}
		var tbl = this.tbl;
		var size = b.length * nbits >> 3;
		var out = new haxe_io_Bytes(new ArrayBuffer(size));
		var buf = 0;
		var curbits = 0;
		var pin = 0;
		var pout = 0;
		while(pout < size) {
			while(curbits < 8) {
				curbits += nbits;
				buf <<= nbits;
				var i = tbl[b.b[pin++]];
				if(i == -1) {
					throw new js__$Boot_HaxeError("BaseCode : invalid encoded char");
				}
				buf |= i;
			}
			curbits -= 8;
			out.b[pout++] = buf >> curbits & 255;
		}
		return out;
	}
};
var haxe_io_Error = $hxEnums["haxe.io.Error"] = { __ename__ : true, __constructs__ : ["Blocked","Overflow","OutsideBounds","Custom"]
	,Blocked: {_hx_index:0,__enum__:"haxe.io.Error",toString:$estr}
	,Overflow: {_hx_index:1,__enum__:"haxe.io.Error",toString:$estr}
	,OutsideBounds: {_hx_index:2,__enum__:"haxe.io.Error",toString:$estr}
	,Custom: ($_=function(e) { return {_hx_index:3,e:e,__enum__:"haxe.io.Error",toString:$estr}; },$_.__params__ = ["e"],$_)
};
var js__$Boot_HaxeError = function(val) {
	Error.call(this);
	this.val = val;
	if(Error.captureStackTrace) {
		Error.captureStackTrace(this,js__$Boot_HaxeError);
	}
};
js__$Boot_HaxeError.__name__ = true;
js__$Boot_HaxeError.__super__ = Error;
js__$Boot_HaxeError.prototype = $extend(Error.prototype,{
});
var js_Boot = function() { };
js_Boot.__name__ = true;
js_Boot.__string_rec = function(o,s) {
	if(o == null) {
		return "null";
	}
	if(s.length >= 5) {
		return "<...>";
	}
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) {
		t = "object";
	}
	switch(t) {
	case "function":
		return "<function>";
	case "object":
		if(o.__enum__) {
			var e = $hxEnums[o.__enum__];
			var n = e.__constructs__[o._hx_index];
			var con = e[n];
			if(con.__params__) {
				s = s + "\t";
				return n + "(" + ((function($this) {
					var $r;
					var _g = [];
					{
						var _g1 = 0;
						var _g2 = con.__params__;
						while(true) {
							if(!(_g1 < _g2.length)) {
								break;
							}
							var p = _g2[_g1];
							_g1 = _g1 + 1;
							_g.push(js_Boot.__string_rec(o[p],s));
						}
					}
					$r = _g;
					return $r;
				}(this))).join(",") + ")";
			} else {
				return n;
			}
		}
		if(((o) instanceof Array)) {
			var str = "[";
			s += "\t";
			var _g3 = 0;
			var _g11 = o.length;
			while(_g3 < _g11) {
				var i = _g3++;
				str += (i > 0 ? "," : "") + js_Boot.__string_rec(o[i],s);
			}
			str += "]";
			return str;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e1 ) {
			var e2 = ((e1) instanceof js__$Boot_HaxeError) ? e1.val : e1;
			return "???";
		}
		if(tostr != null && tostr != Object.toString && typeof(tostr) == "function") {
			var s2 = o.toString();
			if(s2 != "[object Object]") {
				return s2;
			}
		}
		var str1 = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		var k = null;
		for( k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str1.length != 2) {
			str1 += ", \n";
		}
		str1 += s + k + " : " + js_Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str1 += "\n" + s + "}";
		return str1;
	case "string":
		return o;
	default:
		return String(o);
	}
};
var particle_Test = function() { };
particle_Test.__name__ = true;
particle_Test.main = function() {
	var width = window.innerWidth;
	var height = window.innerHeight;
	var renderer = PIXI.autoDetectRenderer(null,width,height);
	window.document.body.appendChild(renderer.view);
	var stage = new PIXI.Container();
	var uniforms = { };
	uniforms.vpw = { type : "i", value : width};
	uniforms.vph = { type : "i", value : height};
	uniforms.offset = { type : "v2", value : { x : -0.0235, y : 0.9794}};
	uniforms.pitch = { type : "v2", value : { x : 50, y : 50}};
	uniforms.resolution = { type : "v2", value : { x : width, y : height}};
	var shaderCode = haxe_Resource.getString("grid_shader");
	var gridShader = new PIXI.Filter("",shaderCode,uniforms);
	var rect = new PIXI.Graphics().drawRect(0,0,width,height);
	rect.filters = [gridShader];
	stage.addChild(rect);
	renderer.render(stage);
};
if( String.fromCodePoint == null ) String.fromCodePoint = function(c) { return c < 0x10000 ? String.fromCharCode(c) : String.fromCharCode((c>>10)+0xD7C0)+String.fromCharCode((c&0x3FF)+0xDC00); }
String.__name__ = true;
Array.__name__ = true;
haxe_Resource.content = [{ name : "grid_shader", data : "cHJlY2lzaW9uIG1lZGl1bXAgZmxvYXQ7DQoNCnVuaWZvcm0gZmxvYXQgdnB3OyAvLyBXaWR0aCwgaW4gcGl4ZWxzDQp1bmlmb3JtIGZsb2F0IHZwaDsgLy8gSGVpZ2h0LCBpbiBwaXhlbHMNCg0KdW5pZm9ybSB2ZWMyIG9mZnNldDsgLy8gZS5nLiBbLTAuMDIzNTAwMDAwMDAwMDAwNDM0IDAuOTc5NDAwMDAwMDAwMDAxN10sIGN1cnJlbnRseSB0aGUgc2FtZSBhcyB0aGUgeC95IG9mZnNldCBpbiB0aGUgbXZNYXRyaXgNCnVuaWZvcm0gdmVjMiBwaXRjaDsgIC8vIGUuZy4gWzUwIDUwXQ0KDQp2b2lkIG1haW4oKSB7DQogIGZsb2F0IGxYID0gZ2xfRnJhZ0Nvb3JkLnggLyB2cHc7DQogIGZsb2F0IGxZID0gZ2xfRnJhZ0Nvb3JkLnkgLyB2cGg7DQoNCiAgZmxvYXQgc2NhbGVGYWN0b3IgPSAxMDAwMC4wOw0KDQogIGZsb2F0IG9mZlggPSAoc2NhbGVGYWN0b3IgKiBvZmZzZXRbMF0pICsgZ2xfRnJhZ0Nvb3JkLng7DQogIGZsb2F0IG9mZlkgPSAoc2NhbGVGYWN0b3IgKiBvZmZzZXRbMV0pICsgKDEuMCAtIGdsX0ZyYWdDb29yZC55KTsNCg0KICBpZiAoaW50KG1vZChvZmZYLCBwaXRjaFswXSkpID09IDAgfHwNCiAgICAgIGludChtb2Qob2ZmWSwgcGl0Y2hbMV0pKSA9PSAwKSB7DQogICAgZ2xfRnJhZ0NvbG9yID0gdmVjNCgwLjAsIDAuMCwgMC4wLCAwLjUpOw0KICB9IGVsc2Ugew0KICAgIGdsX0ZyYWdDb2xvciA9IHZlYzQoMS4wLCAxLjAsIDEuMCwgMS4wKTsNCiAgfQ0KfQ"}];
Object.defineProperty(js__$Boot_HaxeError.prototype,"message",{ get : function() {
	return String(this.val);
}});
js_Boot.__toStr = ({ }).toString;
haxe_crypto_Base64.CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
haxe_crypto_Base64.BYTES = haxe_io_Bytes.ofString(haxe_crypto_Base64.CHARS);
particle_Test.main();
})({});
