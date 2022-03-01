using stx.Config;
using stx.Nano;
using stx.ASys;
using stx.Log;
using eu.ohmrun.Fletcher;

import stx.config.term.Resource;
import stx.config.term.File;

class Main {
	static function main() {
		final log = __.log().global;
					log.includes.push("**/*");
					log.level = DEBUG;
					
		var resource 	= new Resource();
		__.ctx(
			__.asys().local(),
			(x) -> {
				trace(x);
			}
		).load(new File().toFletcher())
		 .submit();

		trace("Hello, world!");
	}
}
