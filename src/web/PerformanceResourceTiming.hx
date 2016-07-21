package web;

import js.html.PerformanceEntry;

@:native("PerformanceResourceTiming")
extern class PerformanceResourceTiming extends PerformanceEntry {
	var initiatorType(default, null):String;
	var redirectStart(default, null):Float;
	var redirectEnd(default, null):Float;
	var fetchStart(default, null):Float;
	var domainLookupStart(default, null):Float;
	var domainLookupEnd(default, null):Float;
	var connectStart(default, null):Float;
	var connectEnd(default, null):Float;
	var secureConnectionStart(default, null):Float;
	var requestStart(default, null):Float;
	var responseStart(default, null):Float;
	var responseEnd(default, null):Float;
	var decodedBodySize(default, null):Float;
	var encodedBodySize(default, null):Float;
	var transferSize(default, null):Float;
}