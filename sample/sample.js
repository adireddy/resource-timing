(function (console, $hx_exports) { "use strict";
var Main = function() {
	window.onload = $bind(this,this._init);
};
Main.main = function() {
	new Main();
};
Main.prototype = {
	_init: function() {
		new ResourceTiming(window);
	}
};
var Reflect = function() { };
Reflect.setField = function(o,field,value) {
	o[field] = value;
};
var ResourceTiming = $hx_exports.ResourceTiming = function(win) {
	this._resources = { };
	this._perfObj = win == null?window.performance:win.performance;
	this._getResources();
};
ResourceTiming.prototype = {
	_getResources: function() {
		if(this._perfObj == null) return;
		var resourceList = this._perfObj.getEntriesByType("resource");
		if(resourceList == null) return;
		var _g = 0;
		while(_g < resourceList.length) {
			var resource = resourceList[_g];
			++_g;
			Reflect.setField(this._resources,resource.name,{ url : resource.name.substring(resource.name.lastIndexOf("/") + 1,resource.name.length), type : resource.initiatorType, timing : { response : resource.responseEnd - resource.responseStart, redirect : resource.redirectEnd - resource.redirectStart, dnsLookup : resource.domainLookupEnd - resource.domainLookupStart, tcp : resource.connectEnd - resource.connectStart, secureConnection : resource.secureConnectionStart > 0?0:resource.connectEnd - resource.secureConnectionStart, fetch : resource.fetchStart > 0?0:resource.responseEnd - resource.fetchStart, request : resource.requestStart > 0?0:resource.responseEnd - resource.requestStart, start : resource.startTime > 0?0:resource.responseEnd - resource.startTime}, size : { decoded : resource.decodedBodySize == null?0:resource.decodedBodySize, encoded : resource.encodedBodySize == null?0:resource.encodedBodySize, transfer : resource.transferSize == null?0:resource.transferSize}});
		}
	}
};
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
Main.main();
})(typeof console != "undefined" ? console : {log:function(){}}, typeof window != "undefined" ? window : exports);
