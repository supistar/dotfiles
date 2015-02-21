/**
 * ==VimperatorPlugin==
 * @name           oxford.js
 * @description    look up words in Oxford Advanced Learner's Dictionary
 * @minVersion     2.1a1pre
 * @author         supistar
 * @version        0.0.1
 * ==/VimperatorPlugin==
 *
 * Usage:
 * :oxford {words} -> look up words in Oxford Advanced Learner's Dictionary
 *
 */
(function(){
    commands.addUserCommand(["oxford"], "Look up a word",
        function(args) {
            var word = (args.length == 1) ? args[0].toString() : args.string;

            if ( !word ) {
                liberator.echo("Usage: oxford [word]");
            } else {
                liberator.open("http://www.oxfordlearnersdictionaries.com/definition/english/" + encodeURIComponent(word), liberator.NEW_TAB);
            }
        }
    );
})();
// vim:sw=4 ts=4 et:
