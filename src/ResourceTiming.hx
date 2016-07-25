import web.Performance;
import web.PerformanceResourceTiming;
import js.html.Window;
import js.Browser;

@:expose class ResourceTiming {

	var _perfObj:Performance;
	var _win:Window;
	var _resources:Dynamic;

	public function new(?win:Window) {
		_resources = {};
		_perfObj = cast (win == null) ? Browser.window.performance: win.performance;
		_getResources();
	}

	function _getResources() {
		if (_perfObj == null) return;

		var resourceList = _perfObj.getEntriesByType("resource");
		if (resourceList == null) return;
		for (resource in resourceList) _addResource(resource);
	}

	inline function _addResource(resource:PerformanceResourceTiming) {
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

	public function setResourceTimingBufferSize(val:Int) {
		if (_perfObj == null || _perfObj.setResourceTimingBufferSize != null) return;
		_perfObj.setResourceTimingBufferSize(val);
	}
}