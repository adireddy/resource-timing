import js.html.Window;
import web.Performance;
import js.Browser;

@:expose class ResourceTiming {

	var _perfObj:Performance;
	var _win:Window;
	var _resources:Dynamic;

	public function new(?win:Window) {
		if (win == null) win = Browser.window;
		_win = win;
		_perfObj = cast _win.performance;
		_resources = {};
		_listResources();
	}

	function _listResources() {
		if (_perfObj == null) return;

		var resourceList = _perfObj.getEntriesByType("resource");
		if (resourceList == null) return;

		for (resource in resourceList) {
			Reflect.setField(_resources, resource.name, {
				url: resource.name.substring(resource.name.lastIndexOf("/") + 1, resource.name.length),
				type: resource.initiatorType,
				timing: {
					response: resource.responseEnd - resource.responseStart,
					redirect: resource.redirectEnd - resource.redirectStart,
					dnsLookup: resource.domainLookupEnd - resource.domainLookupStart,
					tcp: resource.connectEnd - resource.connectStart,
					secureConnection: resource.secureConnectionStart > 0 ? 0 : resource.connectEnd - resource.secureConnectionStart,
					fetch: resource.fetchStart > 0 ? 0 : resource.responseEnd - resource.fetchStart,
					request: resource.requestStart > 0 ? 0 : resource.responseEnd - resource.requestStart,
					start: resource.startTime > 0 ? 0 : resource.responseEnd - resource.startTime
				},
				size: {
					decoded: resource.decodedBodySize == null ? 0 : resource.decodedBodySize,
					encoded: resource.encodedBodySize == null ? 0 : resource.encodedBodySize,
					transfer: resource.transferSize == null ? 0 : resource.transferSize
				}
			});
		}

		trace(_resources);
	}

	function _getFormattedSize(bytes:Float, ?frac:Int = 0):String {
		var sizes = ["Bytes", "KB", "MB", "GB", "TB"];
		if (bytes == 0) return "0";
		var precision = Math.pow(10, frac);
		var i = Math.floor(Math.log(bytes) / Math.log(1024));
		return Math.round(bytes * precision / Math.pow(1024, i)) / precision + " " + sizes[i];
	}

	function setResourceTimingBufferSize(val:Int) {
		if (_perfObj == null || _perfObj.setResourceTimingBufferSize != null) {
			trace("performance.setResourceTimingBufferSize not supported");
			return;
		}
		_perfObj.setResourceTimingBufferSize(val);
	}
}