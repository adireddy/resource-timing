import js.Browser;

class Main {

	public function new() {
		Browser.window.onload = _init;
	}

	function _init() {
		new ResourceTiming(Browser.window);
	}

	static function main() {
		new Main();
	}
}