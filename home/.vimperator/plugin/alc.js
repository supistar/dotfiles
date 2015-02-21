/**
 * ==VimperatorPlugin==
 * @name           alc.js
 * @description    look up words in SPACE ALC
 * @description-ja ALC ‚ÅŒŸõ
 * @minVersion     2.1a1pre
 * @author         masa138
 * @version        0.0.2
 * ==/VimperatorPlugin==
 *
 * Usage:
 * :alc {words} -> look up words in SPACE ALC
 *
 */
(function(){
    commands.addUserCommand(["alc"], "Look up a word",
        function(args) {
            var word = (args.length == 1) ? args[0].toString() : args.string;

            if ( !word ) {
                liberator.echo("Usage: alc [word]");
            } else {
                liberator.open("http://eow.alc.co.jp/" + encodeURIComponent(word) + "/UTF-8/", liberator.NEW_TAB);
            }
        }
    );
})();
// vim:sw=4 ts=4 et:
