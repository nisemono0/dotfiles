//META{"name":"TheBestPluginEver"}*//

class TheBestPluginEver {
	
    getName() { return "The Best Plugin Ever"; }
	getDescription() { return `Literally the most useless and cancerous plugin ever.\n\n "clapclap:" at the first of your message to replace spaces with clap emojis.\n "clapclap(some_emote_name):" to use custom emotes.\n "superclapclap:" for every character instead of every space.\n "ra:" to replace all characters with regional indicators.\n "reverse:" to reverse the message.\n "b:" for the good shit.\n "owo:" for complete fucking cancer.\n "zalgo:" FOR HE RETURNS. \n "cancer:" FoR VeRy SpEcIaL TeXt.\n "vapor:" for aesthetic.\n "spoiler:" for duh, spoilering text.\n "reverse:" txet gnisrever rof.\n "morse:" ..-. --- .-. / - .... .. ...\n "owo2:" for experimental complete fucking cancer.`; }
    getVersion() { return "1.0.1"; }
    getAuthor() { return "Zaltenos"; }

    load() {}

    start() {

        let libLoadedEvent = () => {
            try{ this.onLibLoaded(); }
            catch(err) { console.error(this.getName(), "fatal error, plugin could not be started!", err); try { this.stop(); } catch(err) { console.error(this.getName() + ".stop()", err); } }
        };

		let lib = document.getElementById("NeatoBurritoLibrary");
		if(!lib) {
			lib = document.createElement("script");
			lib.id = "NeatoBurritoLibrary";
			lib.type = "text/javascript";
			lib.src = "https://rawgit.com/Metalloriff/BetterDiscordPlugins/master/Lib/NeatoBurritoLibrary.js";
			document.head.appendChild(lib);
		}
		this.forceLoadTimeout = setTimeout(libLoadedEvent, 30000);
        if(typeof window.NeatoLib !== "undefined") libLoadedEvent();
		else lib.addEventListener("load", libLoadedEvent);

	}
	
	onLibLoaded() {

		NeatoLib.Updates.check(this);

		this.onChatInput = e => {

			const chatbox = e.target;

			if(e.which == 13 && !e.shiftKey && chatbox.value){

				let chatboxValue = chatbox.value.trim(), changed = false;

				if(chatboxValue.startsWith("clapclap") || chatboxValue.startsWith("superclapclap")){

					let getClapClap = chatboxValue.substring(0, chatboxValue.indexOf(":") + 1), emote = "clap", definedEmote = getClapClap.substring(getClapClap.indexOf("(") + 1, getClapClap.indexOf(")"));

					if(definedEmote) emote = definedEmote;

					emote = " :" + emote  + ": ";

					chatboxValue = chatboxValue.replace(getClapClap, "").split(chatboxValue.startsWith("super") ? "" : " ").join(emote);

					if(chatboxValue.startsWith(emote)) chatboxValue += emote;

					changed = true;
				}

				if(chatboxValue.toLowerCase().startsWith("ra:")){

                    chatboxValue = chatboxValue.replace("ra:", "");
                    

					for(let i = 0; i < chatboxValue.length; i++) chatboxValue = chatboxValue.toLowerCase().replace('a', '🇦 ').replace('b', '🇧 ').replace('c', '🇨 ').replace('d', '🇩 ').replace('e', '🇪 ').replace('f', '🇫 ').replace('g', '🇬 ').replace('h', '🇭 ').replace('i', '🇮 ').replace('j', '🇯 ').replace('k', '🇰 ').replace('l', '🇱 ').replace('m', '🇲 ').replace('n', '🇳 ').replace('o', '🇴 ').replace('p', '🇵 ').replace('q', '🇶 ').replace('r', '🇷 ').replace('s', '🇸 ').replace('t', '🇹 ').replace('u', '🇺 ').replace('v', '🇻 ').replace('w', '🇼 ').replace('x', '🇽 ').replace('y', '🇾 ').replace('z', '🇿 ').replace('?', '❓ ').replace('!', '❗ ');                    
                    chatboxValue = chatboxValue.split("1").join(":one:");
                    chatboxValue = chatboxValue.split("2").join(":two:");
                    chatboxValue = chatboxValue.split("3").join(":three:");
                    chatboxValue = chatboxValue.split("4").join(":four:");
                    chatboxValue = chatboxValue.split("5").join(":five:");
                    chatboxValue = chatboxValue.split("6").join(":six:");
                    chatboxValue = chatboxValue.split("7").join(":seven:");
                    chatboxValue = chatboxValue.split("8").join(":eight:");
                    chatboxValue = chatboxValue.split("9").join(":nine:");
                    chatboxValue = chatboxValue.split("0").join(":zero:");
                    
                    chatboxValue = chatboxValue.replace(/\s\s+/g, '    ').slice(0, 2000);

					changed = true;
				}
                
                if(chatboxValue.startsWith("comic:")){

					let alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", temp = chatboxValue.split(" ").join("\t");

					for(let i = 0; i < alphabet.length; i++) temp = temp.replace("comic:", "").split(alphabet[i]).join("[a" + i + "]");
					for(let i = 0; i < alphabet.length; i++) temp = temp.split("[a" + i + "]").join(":ComicSans" + alphabet[i].toUpperCase() + ": ");

					temp = temp.split("?").join(":question:");
                    temp = temp.split("!").join(":exclamation:");
                    
                    temp = temp.split("1").join(":one:");
                    temp = temp.split("2").join(":two:");
                    temp = temp.split("3").join(":three:");
                    temp = temp.split("4").join(":four:");
                    temp = temp.split("5").join(":five:");
                    temp = temp.split("6").join(":six:");
                    temp = temp.split("7").join(":seven:");
                    temp = temp.split("8").join(":eight:");
                    temp = temp.split("9").join(":nine:");
                    temp = temp.split("0").join(":zero:");

					chatboxValue = temp;

					changed = true;
				}
                
                if(chatboxValue.startsWith("zalgo:")){
                    
					chatboxValue = chatboxValue.replace("zalgo:", "").trim();

					chatboxValue = chatboxValue.split('!').join('!̬͇̫').split('"').join('͔̖̮̟͎͓̱"͚̰̜ͅ').split('#').join('̙̘̪#̺').split('$').join('$͔').split('%').join('̬̯̟̥%͈̣').split('&').join('̙̠&̬̱͇').split("'").join("̪̘'").split('(').join('͕͚̮̘̝̟(̦̱̣̪̯̺').split(')').join('̰̫̪)̞͕').split('*').join('̟͎̰*͍̖̭̮͖').split('+').join('͇̼͉̲ͅ+͍͉͖̖͙̫').split(',').join('̲̙̝̲͍,̠̖͍͍').split('-').join('͖̭̻̰̠-̫').split('.').join('̼.').split('/').join('̤̜͈/͈̮̯̭').split('0').join('̩͇0̤̬̞').split('1').join('̩̘1̝͔̥̜͙̝ͅ').split('2').join('͉2̪').split('3').join('̱̝͚͖3̰͓͇̫̙').split('4').join('͕̱͎4̰̞̥͚').split('5').join('̳̥̤̼̼5͍̟͓̖̻͓').split('6').join('͉̦̹6͇̲͎̳').split('7').join('ͅ7̣̲͈̜').split('8').join('8').split('9').join('̰͉̻̤̬̩9̤͎͍͔͍̜').split(':').join('̬̗̗͉͙:̲̩̰̼̘̘ͅ').split(';').join('͙̮;͍̪͔͇̺̞͈').split('<').join('͙͖̩͙̟̲̦<').split('=').join('̖̫͎=').split('>').join('̱̘̘̦>̗̥̖̬̤͎̘').split('?').join('?͕͖̩̺̟̻̦').split('@').join('̼̞̹̭̖@͚͓͕͙').split('A').join('̫͔̣A̱̰̝').split('B').join('͖̘B̗').split('C').join('̬̩̫̱̱̪ͅC').split('D').join('̻̮̞̲͕̜̱D̟̹͇̭').split('E').join('̫E̺').split('F').join('̗F͓͓̰͙̫').split('G').join('̼͍̞̘̭G͎').split('H').join('̜̦̯H͈̲̺').split('I').join('͈̮̻͉I̩̠̥͚̘̮̩').split('J').join('͓J̟').split('K').join('͇K͕̟').split('L').join('̩͔̯͔L̙͓͖').split('M').join('̟̖̠M̗͍͖̰̳').split('N').join('̤͔̲N̹͓').split('O').join('̥̳͇̘̳̩O͙͓̣͖ͅ').split('P').join('̤̟P̘̯̰͙͇͈').split('Q').join('͚̪Q͚̬̦̗').split('R').join('̱̩̰͉̦R̟͔̻').split('S').join('̗̫̭̮̗̗̖S̮͈͚̯').split('T').join('͚̪̳̼T̰̜͚̫̱').split('U').join('̘̠̫Ṷ͙͖̞͖').split('V').join('̱̗̼͇͍̭̟V̺̺').split('W').join('̗̱̤̠W̳͇͉̙̱').split('X').join('̭͍̼̼͉͍͈X').split('Y').join('͖̲̻̫̙Y̳͈̫̺̝').split('Z').join('̦̞̙̘̺̮͚Z̘̼̺').split('[').join('̜[̝̺').split("\\").join("ͅ\̖̞̮").split(']').join(']̹̯͙̣').split('^').join('̮̮͙̯͙ͅͅ^̘̣͔̤͔̲').split('_').join('͚̬̞_͉͔̭').split('`').join('`̰̯͎').split('a').join('̟̲̘͎͕̣a̩͇͍̬̞̼͓').split('b').join('̹̰̘̮̮̳̱b̘̙͓̹').split('c').join('̼͖̬͙̰c').split('d').join('͚d̟̦̻̬').split('e').join('̫͍e̯̞ͅ').split('f').join('̮f͓̤͈').split('g').join('͔̲͓̟̞̳̰g̙͙̯').split('h').join('͙h').split('i').join('̟̥̠̟͇i͎').split('j').join('̪j̯̠').split('k').join('k̙̲̜̲̩').split('l').join('̯͕̯̹l̻͚͚̖̫̘̝').split('m').join('m͙̥').split('n').join('͖͓̮̱͔͉n̪̯ͅ').split('o').join('͔̬o̙͎̘').split('p').join('̻͎̭̹p͚̦').split('q').join('͕͓q͙͖ͅ').split('r').join('̪͓̹͈r').split('s').join('̖̤̙͓̭͔ͅs̤̖̳̤̫̻').split('t').join('̳̘̫̼͎̘ṱ').split('u').join('̦̬̳̬̹͇u͍͎̲').split('v').join('̖͔̩̙̱̯v̱').split('w').join('̩̦̲̭w̥͇͔̗͙̦ͅ').split('x').join('̮x̞̱̼͇̣͓ͅ').split('y').join('̰̪̤̖̝ỵ͇͕̝͇').split('z').join('z̰̪̖̩͙̞̥').split('{').join('̟͓̟̮{').split('|').join('̫̼̰͚ͅ|̲').split('}').join('͓}̟̥̲').split('~').join('̟~̫͙̠').split('').join('').split('¡').join('̫̣̬͚̘¡̯͇̙̞̫').split('¢').join('̠̹̝̝̘̝¢̼̜͉̳̩̤').split('£').join('̞͇£̫̫̼̼͍̤').split('¤').join('̼͇̱͉̩¤̟͍̦').split('¥').join('̭̖̱̠̟͖¥̭͖̺̞͚̰̲').split('¦').join('̝¦͖͓͚̺̬̝̤').split('§').join('͉͔̲§͎̦̺').split('¨').join('͖͔͕̭¨').split('©').join('̘̮̞͙̫͙©̤̦').split('ª').join('̝̯̯ª̞̜̘̤͈').split('«').join('̦̣͖̘͙̺̻«̼͕̻').split('¬').join('̣͇̟̘̫̤̝¬͎̤̺').split('®').join('̗̰̦͖̞̞̻®̙̣̦̫̜ͅ').split('¯').join('͈̙͇̱̲̻͚¯̳̠̻̲̫̬').split('°').join('͖̖̺͇̼°͇̜̥̳ͅ').split('±').join('̤̝̹͉±̮͍̜').split('²').join('͍͙̫̦²̥̣̼').split('³').join('̼³̙̼̭').split('´').join('̝̥̥´̩̘̪̠̬').split('µ').join('̤̤̦̣͓̺̤µ̠͎͇͇̻͕').split('¶').join('̮̩̘¶ͅ').split('·').join('̣·͓̮').split('¸').join('̟̲̹͉̼̰̩¸͚͔͕̼').split('¹').join('̠¹̖̜̣̫͓̳̦').split('º').join('͎̰̣̬̞̪º͕͈̰̼').split('»').join('̪͕̗̱̯ͅ»̪͎͍̳').split('¼').join('̘͙̠̪¼̱̺̳͍̦̼').split('½').join('̩̬̙½͚̰̞͈').split('¾').join('̘̯¾̠̣̺͔̞͚͈').split('¿').join('̩̮̠̩̦̗̜¿̣̹̤̤͍̤');

					if(chatbox.value == chatbox.value.toUpperCase()) chatboxValue = chatboxValue.toUpperCase();

					changed = true;
                }
                
                if(chatboxValue.startsWith("cancer:")) {
                    
                    let temp = chatboxValue.replace("cancer:","");
                    
                    for(let i = 0; i < chatboxValue.length; i++) temp = temp.replace(/\w\S+/g, function(txt){return txt.charAt(0).toUpperCase() + txt.charAt(1).toLowerCase() + txt.charAt(2).toUpperCase() + txt.charAt(3).toLowerCase() + txt.charAt(4).toUpperCase() + txt.charAt(5).toLowerCase() + txt.charAt(6).toUpperCase() + txt.charAt(7).toLowerCase() + txt.charAt(8).toUpperCase() + txt.charAt(9).toLowerCase() + txt.charAt(10).toUpperCase() + txt.charAt(11).toLowerCase() + txt.charAt(12).toUpperCase() + txt.charAt(13).toLowerCase() + txt.charAt(14).toUpperCase()});
                    
                    chatboxValue = temp;

					changed = true;
                }

				if(chatboxValue.startsWith("reverse:")) {
					chatboxValue = chatboxValue.replace("reverse:", "").split("").reverse().join("");
					changed = true;
				}

				if(chatboxValue.startsWith("owo:")) {

					const cancer = ["owo", "OwO", "uwu", "UwU", ">w<", "^w^"];
                    
                    chatboxValue = chatboxValue.replace("owo:", "");

					chatboxValue = chatboxValue.replace(/(?:r|l)/g, "w").replace(/(?:R|L)/g, "W").replace(/n([aeiou])/g, 'ny$1').replace(/N([aeiou])/g, 'Ny$1').replace(/N([AEIOU])/g, 'Ny$1').replace(/ove/g, "uv");

					chatboxValue += " " + cancer[cancer.length * Math.random() << 0];

					if(chatbox.value == chatbox.value.toUpperCase()) chatboxValue = chatboxValue.toUpperCase();

					changed = true;
				}
                
                if(chatboxValue.startsWith("owo2:")) {

					const cancer = ["owo", "OwO", "uwu", "UwU", ">w<", "^w^"];
                    
                    chatboxValue = chatboxValue.replace("owo2:", "");

					chatboxValue = chatboxValue.replace(/(?:r|l)/g, "w").replace(/(?:R|L)/g, "W").replace(/n([aeiou])/g, 'ny$1').replace(/N([aeiou])/g, 'Ny$1').replace(/N([AEIOU])/g, 'Ny$1').replace(/ove/g, "uv").replace(/ors/gi, 'os').replace(/sen/gi, 'swen').replace(/stru/gi, 'stwu').replace(/gra/gi, 'gwa').replace(/mar/gi, 'mer').replace(/po/gi, 'pwo').replace(/ter/gi, 'tew').replace(/and/gi, 'an').replace(/you/gi, 'u').replace(/your/gi, 'ur').replace(/just/gi, 'jus').replace(/read/gi, 'wead').replace(/mo/gi, 'mwo').replace(/the/gi, 'tw').replace(/whole/gi, 'wol').replace(/rd/gi, 'wd').replace(/eal/gi, 'ewl').replace(/is/gi, 'iws').replace(/fu/gi, 'fwu').replace(/bu/gi, 'bwu').replace(/pos/gi, 'powos').replace(/isn/gi, 'iwswnw').replace(/ve/gi, 'bwe').replace(/ye/gi, 'nye').replace(/oe/gi, 'wo').replace(/on/gi, 'own').replace(/ann/gi, 'anya').replace(/to/gi, 'two').replace(/eadi/gi, 'eadwi').replace(/ini/gi, 'winib').replace(/att/gi, 'watt').replace(/what/gi, 'wat').replace(/oi/gi, 'woi').replace(/hav/gi, 'hab').replace(/ive/gi, 'wib').replace(/up/gi, 'ub').replace(/oo/gi, 'owo').replace(/halleng/gi, 'walengb').replace(/me /gi, 'mii ').replace(/determination/gi, 'detewemwinyanyatiom');
                    
					chatboxValue += " " + cancer[cancer.length * Math.random() << 0];

					if(chatbox.value == chatbox.value.toUpperCase()) chatboxValue = chatboxValue.toUpperCase();

					changed = true;
				}
                
                if(chatboxValue.toLowerCase().startsWith("owomic:")) {
                    
                    const cancer = ["owo", "OwO", "uwu", "UwU"];
                    
                    chatboxValue = chatboxValue.replace("owomic:", ":");
                    
                    let alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

					chatboxValue = chatboxValue.replace(/(?:r|l)/g, "w").replace(/(?:R|L)/g, "W").replace(/n([aeiou])/g, 'ny$1').replace(/N([aeiou])/g, 'Ny$1').replace(/N([AEIOU])/g, 'Ny$1').replace(/ove/g, "uv");

					chatboxValue += " " + cancer[cancer.length * Math.random() << 0];

					for(let i = 0; i < alphabet.length; i++) chatboxValue = chatboxValue.split(alphabet[i]).join("[a" + i + "]").split(" ").join("\t").replace(":","");
                    for(let i = 0; i < alphabet.length; i++) chatboxValue = chatboxValue.split("[a" + i + "]").join(":ComicSans" + alphabet[i].toUpperCase() + ": ");

					chatboxValue = chatboxValue.split("?").join(":question:");
                    chatboxValue = chatboxValue.split("!").join(":exclamation:");
                    
                    chatboxValue = chatboxValue.split("1").join(":one:");
                    chatboxValue = chatboxValue.split("2").join(":two:");
                    chatboxValue = chatboxValue.split("3").join(":three:");
                    chatboxValue = chatboxValue.split("4").join(":four:");
                    chatboxValue = chatboxValue.split("5").join(":five:");
                    chatboxValue = chatboxValue.split("6").join(":six:");
                    chatboxValue = chatboxValue.split("7").join(":seven:");
                    chatboxValue = chatboxValue.split("8").join(":eight:");
                    chatboxValue = chatboxValue.split("9").join(":nine:");
                    chatboxValue = chatboxValue.split("0").join(":zero:");
                    
                    if(chatbox.value == chatbox.value.toUpperCase()) chatboxValue = chatboxValue.toUpperCase();
                    
                    chatboxValue = chatboxValue;
                    
					changed = true;
                }
                
                if(chatboxValue.toLowerCase().startsWith("owoi:")) {
                    
                    const cancer = ["owo", "OwO", "uwu", "UwU"];
                    
                    chatboxValue = chatboxValue.replace("owoi:", "");

					chatboxValue = chatboxValue.replace(/(?:r|l)/g, "w").replace(/(?:R|L)/g, "W").replace(/n([aeiou])/g, 'ny$1').replace(/N([aeiou])/g, 'Ny$1').replace(/N([AEIOU])/g, 'Ny$1').replace(/ove/g, "uv");

					chatboxValue += " " + cancer[cancer.length * Math.random() << 0];
                    
                    if(chatbox.value == chatbox.value.toLowerCase()) chatboxValue = chatboxValue.toLowerCase();

					for(let i = 0; i < chatboxValue.length; i++) chatboxValue = chatboxValue.toLowerCase().replace('a', '🇦 ').replace('b', '🇧 ').replace('c', '🇨 ').replace('d', '🇩 ').replace('e', '🇪 ').replace('f', '🇫 ').replace('g', '🇬 ').replace('h', '🇭 ').replace('i', '🇮 ').replace('j', '🇯 ').replace('k', '🇰 ').replace('l', '🇱 ').replace('m', '🇲 ').replace('n', '🇳 ').replace('o', '🇴 ').replace('p', '🇵 ').replace('q', '🇶 ').replace('r', '🇷 ').replace('s', '🇸 ').replace('t', '🇹 ').replace('u', '🇺 ').replace('v', '🇻 ').replace('w', '🇼 ').replace('x', '🇽 ').replace('y', '🇾 ').replace('z', '🇿 ').replace('?', '❓ ').replace('!', '❗ ');                    
                    chatboxValue = chatboxValue.split("1").join(":one:");
                    chatboxValue = chatboxValue.split("2").join(":two:");
                    chatboxValue = chatboxValue.split("3").join(":three:");
                    chatboxValue = chatboxValue.split("4").join(":four:");
                    chatboxValue = chatboxValue.split("5").join(":five:");
                    chatboxValue = chatboxValue.split("6").join(":six:");
                    chatboxValue = chatboxValue.split("7").join(":seven:");
                    chatboxValue = chatboxValue.split("8").join(":eight:");
                    chatboxValue = chatboxValue.split("9").join(":nine:");
                    chatboxValue = chatboxValue.split("0").join(":zero:");
                    
                    chatboxValue = chatboxValue.replace(/\s\s+/g, '    ').slice(0, 2000);
                    
					changed = true;
                }
                
                if(chatboxValue.toLowerCase().startsWith("squared:")) {
                    
                    chatboxValue = chatboxValue.replace("squared:", "");
                    
                    for(let i = 0; i < chatboxValue.length; i++) chatboxValue = chatboxValue.toLowerCase().replace('a', '🅰 ').replace('b', '🅱 ').replace('c', '🅲 ').replace('d', '🅳 ').replace('e', '🅴 ').replace('f', '🅵 ').replace('g', '🅶 ').replace('h', '🅷 ').replace('i', '🅸 ').replace('j', '🅹 ').replace('k', '🅺 ').replace('l', '🅻 ').replace('m', '🅼 ').replace('n', '🅽 ').replace('o', '🅾 ').replace('p', '🅿 ').replace('q', '🆀 ').replace('r', '🆁 ').replace('s', '🆂 ').replace('t', '🆃 ').replace('u', '🆄 ').replace('v', '🆅 ').replace('w', '🆆 ').replace('x', '🆇 ').replace('y', '🆈 ').replace('z', '🆉 ').replace('?', '❓ ').replace('!', '❗ ');   
                
                    chatboxValue = chatboxValue;
                    
                    changed = true;
                }
                
                if(chatboxValue.startsWith("vapor:")) {
                    
                    chatboxValue = chatboxValue.replace("vapor:","");
                    
                    let japanese = "リサフランク現代のコンピュ竹内 まりや若者が履く流行のスニーカー真夜中のドアホットドッグマスターストライカーソニーブギ新しい日の誕生ライフ - ヒスイ蒸気波 無線゠ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴヵヶヷヸヹヺ・ーヽヾヿぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔゕゖ゙゚゛゜ゝゞゟ亜哀挨愛曖悪握圧扱宛嵐安案暗以衣位囲医依委威為畏胃尉異移萎偉椅彙意違維慰遺緯域育壱逸茨芋引印因咽姻員院淫陰飲隠韻右宇羽雨唄鬱畝浦運雲永泳英映栄営詠影鋭衛易疫益液駅悦越謁閲円延沿炎怨宴媛援園煙猿遠鉛塩演縁艶汚王凹央応往押旺欧殴桜翁奥横岡屋億憶臆虞乙俺卸音恩温穏下化火加可仮何花佳価果河苛科";
                                        
                    for(let i = 0; i < chatboxValue.length; i++) chatboxValue = chatboxValue.replace(' ','　').replace('a','ａ').replace('b','ｂ').replace('c','ｃ').replace('d','ｄ').replace('e','ｅ').replace('f','ｆ').replace('g','ｇ').replace('h','ｈ').replace('i','ｉ').replace('j','ｊ').replace('k','ｋ').replace('l','ｌ').replace('m','ｍ').replace('n','ｎ').replace('o','ｏ').replace('p','ｐ').replace('q','ｑ').replace('r','ｒ').replace('s','ｓ').replace('t','ｔ').replace('u','ｕ').replace('v','ｖ').replace('w','ｗ').replace('x','ｘ').replace('y','ｙ').replace('z','ｚ').replace('A','Ａ').replace('B','Ｂ').replace('C','Ｃ').replace('D','Ｄ').replace('E','Ｅ').replace('F','Ｆ').replace('G','Ｇ').replace('H','Ｈ').replace('I','Ｉ').replace('J','Ｊ').replace('K','Ｋ').replace('L','Ｌ').replace('M','Ｍ').replace('N','Ｎ').replace('O','Ｏ').replace('P','Ｐ').replace('Q','Ｑ').replace('R','Ｒ').replace('S','Ｓ').replace('T','Ｔ').replace('U','Ｕ').replace('V','Ｖ').replace('W','Ｗ').replace('X','Ｘ').replace('Y','Ｙ').replace('Z','Ｚ').replace('0','０').replace('1','１').replace('2','２').replace('3','３').replace('4','４').replace('5','５').replace('6','６').replace('7','７').replace('8','８').replace('9','９').replace('`','｀').replace('!','！').replace('"','＂').replace('$','＄').replace('%','％').replace('^','＾').replace('&','＆').replace('*','＊').replace('(','（').replace(')','）').replace('_','＿').replace('+','＋').replace('-','－').replace('=','＝').replace('[','［').replace(']','］').replace('{','｛').replace('}','｝').replace(';','；').replace("'",'＇').replace('#','＃').replace(':','：').replace('@','＠').replace('~','～').replace(',','，').replace('.','．').replace('/','／').replace('<','＜').replace('>','＞').replace('?','？').replace('\\','＼').replace('|','｜');;
                                       
                    chatboxValue = "「" + chatboxValue + "」";
                    
                    changed = true;
                }
                
                if(chatboxValue.startsWith("morse:")) {
                    
                    chatboxValue = chatboxValue.replace("morse:","").toUpperCase();

                    for(let i = 0; i < chatboxValue.length; i++) chatboxValue = chatboxValue.replace('A','.- ').replace('B','-... ').replace('C','-.-. ').replace('D','-.. ').replace('E','. ').replace('F','..-. ').replace('G','--. ').replace('H','.... ').replace('I','.. ').replace('J','.--- ').replace('K','-.- ').replace('L','.-.. ').replace('M','-- ').replace('N','-. ').replace('O','--- ').replace('P','.--. ').replace('Q','--.- ').replace('R','.-. ').replace('S','... ').replace('T','- ').replace('U','..- ').replace('V','...- ').replace('W','.-- ').replace('X','-..- ').replace('Y','-.-- ').replace('Z','--.. ').replace('1','.---- ').replace('2','..--- ').replace('3','...-- ').replace('4','....- ').replace('5','..... ').replace('6','-.... ').replace('7','--... ').replace('8','---.. ').replace('9','----. ').replace('0','----- ');                    
                                        
                    for(let i = 0; i < chatboxValue.length; i++) chatboxValue = chatboxValue.replace('  ',' / ');
                    
                    chatboxValue = chatboxValue;
                    
                    changed = true;
                }
                
				if(chatboxValue.toLowerCase().startsWith("space:")) {
					chatboxValue = chatboxValue.replace("space:","").split("").join(" ");
					changed = true;
				}
                
                if(chatboxValue.startsWith("spoiler:")) {
					let temp = chatboxValue.replace("spoiler:","");
                    
                    temp = temp.split("").join("||||");
                    temp = "||" + temp + "||";

                    chatboxValue = temp.slice(0, 2000);;
					changed = true;
				}
                
				if(chatboxValue.toLowerCase().startsWith("b:")) {
					chatboxValue = chatboxValue.substring(2, chatboxValue.length).split("b").join(":b:");
					changed = true;
				}
				
				if(changed) {
					chatbox.select();
					document.execCommand("insertText", false, chatboxValue);
				}

			}

		};

		this.switch();

		NeatoLib.Events.attach("switch", this.switchEvent = () => this.switch());

		NeatoLib.Events.onPluginLoaded(this);

	}
	
	switch() {
		const chatbox = NeatoLib.Chatbox.get();
		if(chatbox) chatbox.addEventListener("keydown", this.onChatInput);
	}
	
    stop() {
		const chatbox = NeatoLib.Chatbox.get();
		if(chatbox) chatbox.removeEventListener("keydown", this.onChatInput);
		NeatoLib.Events.detach("switch", this.switchEvent);
	}
	
}
