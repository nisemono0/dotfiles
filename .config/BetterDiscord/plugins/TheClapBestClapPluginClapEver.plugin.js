/**
 * @name TheClapBestClapPluginClapEver
 * @invite 
 * @authorLink 
 * @donate 
 * @website 
 * @source 
 */

module.exports = (() =>
{
    const config =
    {
		info:
		{
			name: "TheClapBestClapPluginClapEver",
			authors:
			[
				{
					name: "",
				}
			],
			version: "2.1.0",
			description: "Literally useless, toxic cancer. Write 'clapclap$' at the beginning of your message to separate each word with a clap emoji. Write 'clapclap( :your_emoji: )$' to separate each word with your own custom emoji. 'superclapclap$' or 'superclapclap( :emoji: )$' for every letter instead of every word. 'ra$' to replace every letter with a regional indicator emoji. 'reverse$' to reverse your message. 'b$' to replace every 'b$' for the good shit. 'woke$' FoR vErY sPeCiAl TeXt. 'owo$' if you have no will to live. 'vapor$' for aesthetic text. 'spoiler$' for spoilering text, duh. 'owo2$' for experimental complete fucking cancer. 'square$' for squared text. 'space$' for spacing out.",
		},
    };

    return (([Plugin, Api]) => {

		const plugin = (Plugin, Api) =>
		{
			const { DiscordModules, Patcher } = Api;

			return class TheClapBestClapPluginClapEver extends Plugin
			{
				constructor()
				{
					super();
				}
	
				onStart()
				{
					Patcher.after(DiscordModules.MessageActions, "sendMessage", (_, [, message]) =>
					{
						const content = message.content.toLowerCase();
						const clapclap = (/^clapclap(\S| )*\$ /g).exec(content) || (/^superclapclap(\S| )*\$ /g).exec(content);
						
						if (clapclap)
						{	
							const filler = clapclap[0].includes("(") && clapclap[0].includes(")")
								? clapclap[0].substr(clapclap[0].indexOf("(") + 1, clapclap[0].indexOf(")") - clapclap[0].indexOf("(") - 1)
								: " :clap: ";
								
							message.content = message.content.substr(clapclap[0].length, message.content.length)
								.split(clapclap[0].startsWith("super") ? "" : " ")
								.join(filler);
								
							message.content = filler + message.content + filler;

							return;
						}

						switch (content.split("$")[0])
						{
							case "ra":
								const ra = (/^ra\$ /g).exec(content);

								message.content = message.content.substr(ra[0].length, message.content.length)
									.split(" ")
									.join("\t")
									.replace(/[A-Za-z]/g, x => ` :regional_indicator_${x}: `)
                                    .replace(/( :regional_indicator_I: )/g, " :regional_indicator_i: ")
                                    .replace(/1/g, " :one: ")
                                    .replace(/2/g, " :two: ")
                                    .replace(/3/g, " :three: ")
                                    .replace(/4/g, " :four: ")
                                    .replace(/5/g, " :five: ")
                                    .replace(/6/g, " :six: ")
                                    .replace(/7/g, " :seven: ")
                                    .replace(/8/g, " :eight: ")
                                    .replace(/9/g, " :nine: ")
                                    .replace(/!/g, " :exclamation: ")
                                    .replace(/\?/g, " :question: ");
								
								break;

							case "reverse":
								const reverse = (/^reverse\$ /g).exec(content);

								message.content = message.content.substr(reverse[0].length, message.content.length)
									.split("")
									.reverse()
									.join("");

								break;

							case "owo":
								const owo = (/^owo\$ /g).exec(content);

								message.content = message.content.substr(owo[0].length, message.content.length)
									.replace(/(?:r|l)/g, "w")
									.replace(/(?:R|L)/g, "W")
									.replace(/n([aeiou])/g, "ny$1")
									.replace(/N([AEIOU])/g, "Ny$1")
									.replace(/ove/g, "uv")
									.replace(/OVE/g, "UV")
									+ " " + ["owo", "OwO", "uwu", "UwU", ">w<", "^w^", "♥w♥"][7 * Math.random() << 0];

								break;

							case "b":
								const b = (/^b\$ /g).exec(content);

								message.content = message.content.substr(b[0].length, message.content.length)
									.replace(/b/g, ":b:");

								break;
							
							case "woke":
								const woke = (/^woke\$ /g).exec(content);

								message.content = message.content.substr(woke[0].length, message.content.length)
                                    .replace(/ /g,"  ")
									.replace(/.{2}/gm, c => c[0].toUpperCase() + c[1].toLowerCase())
                                    .replace(/  /g," ");

								break;
                                
                            case "owo2":
								const owo2 = (/^owo2\$ /g).exec(content);

								message.content = message.content.substr(owo2[0].length, message.content.length)
									.replace(/(?:r|l)/g, "w")
									.replace(/(?:R|L)/g, "W")
									.replace(/n([aeiou])/g, "ny$1")
									.replace(/N([AEIOU])/g, "Ny$1")
									.replace(/ove/g, "uv")
									.replace(/OVE/g, "UV")
                                    .replace(/ors/g, 'os')
                                    .replace(/sen/g, 'swen')
                                    .replace(/stru/g, 'stwu')
                                    .replace(/gra/g, 'gwa')
                                    .replace(/mar/g, 'mer')
                                    .replace(/po/g, 'pwo')
                                    .replace(/ter/g, 'tew')
                                    .replace(/and/g, 'an')
                                    .replace(/you/g, 'u')
                                    .replace(/your/g, 'ur')
                                    .replace(/just/g, 'jus')
                                    .replace(/read/g, 'wead')
                                    .replace(/mo/g, 'mwo')
                                    .replace(/the/g, 'tw')
                                    .replace(/whole/g, 'wol')
                                    .replace(/rd/g, 'wd')
                                    .replace(/eal/g, 'ewl')
                                    .replace(/is/g, 'iws')
                                    .replace(/fu/g, 'fwu')
                                    .replace(/bu/g, 'bwu')
                                    .replace(/pos/g, 'powos')
                                    .replace(/isn/g, 'iwswnw')
                                    .replace(/ve/g, 'bwe')
                                    .replace(/ye/g, 'nye')
                                    .replace(/oe/g, 'wo')
                                    .replace(/on/g, 'own')
                                    .replace(/ann/g, 'anya')
                                    .replace(/to/g, 'two')
                                    .replace(/eadi/g, 'eadwi')
                                    .replace(/ini/g, 'winib')
                                    .replace(/att/g, 'watt')
                                    .replace(/what/g, 'wat')
                                    .replace(/oi/g, 'woi')
                                    .replace(/hav/g, 'hab')
                                    .replace(/ive/g, 'wib')
                                    .replace(/up/g, 'ub')
                                    .replace(/oo/g, 'owo')
                                    .replace(/halleng/g, 'walengb')
                                    .replace(/me /g, 'mii ')
                                    .replace(/determination/g, 'detewemwinyanyatiom')
									+ " " + ["owo", "OwO", "uwu", "UwU", ">w<", "^w^", "♥w♥"][7 * Math.random() << 0];

								break;
                                
                            case "space":
								const space = (/^space\$ /g).exec(content);

								message.content = message.content.substr(space[0].length, message.content.length)
                                    .split("")
                                    .join(" ");

								break;
                                
                            case "spoiler":
								const spoiler = (/^spoiler\$ /g).exec(content);

								message.content = message.content.substr(spoiler[0].length, message.content.length)
                                    .split("")
                                    .join("")
                                    .replace(/[^|]/g, s => `||${s}||`);

								break;
  
                            case "vapor":
								const vapor = (/^vapor\$ /g).exec(content);
                                
                                var japanese = ['リ','サ','フ','ラ','ン','ク','現','代','の','コ','ン','ピ','ュ','竹','内',' ','ま','り','や','若','者','が','履','く','流','行','の','ス','ニ','ー','カ','ー','真','夜','中','の','ド','ア','ホ','ッ','ト','ド','ッ','グ','マ','ス','タ','ー','ス','ト','ラ','イ','カ','ー','ソ','ニ','ー','ブ','ギ','新','し','い','日','の','誕','生','ラ','イ','フ',' ','-','ヒ','ス','イ','蒸','気','波','無','線','゠','ァ','ア','ィ','イゥ','ウェ','エ','ォ','オ','カ','ガ','キ','ギ','ク','グ','ケ','ゲ','コ','ゴ','サ','ザ','シ','ジ','ス','ズ','セ','ゼ','ソ','ゾ','タ','ダ','チ','ヂ','ッ','ツ','ヅ','テ','デ','ト','ド','ナ','ニ','ヌ','ネ','ノ','ハ','バ','パ','ヒ','ビ','ピ','フ','ブ','プ','ヘ','ベ','ペ','ホ','ボ','ポ','マ','ミ','ム','メ','モャ','ヤュ','ユ','ョ','ヨ','ラ','リ','ル','レ','ロヮ','ワ','ヰ','ヱ','ヲ','ン','ヴ','ヵヶ','ヷ','ヸ','ヹ','ヺ','・','ー','ヽ','ヾ','ヿ','ぁ','あ','ぃ','い','ぅ','う','ぇ','え','ぉ','お','か','が','き','ぎ','く','ぐ','け','げ','こ','ご','さ','ざ','し','じ','す','ず','せ','ぜ','そ','ぞ','た','だ','ち','ぢ','っ','つ','づ','て','で','と','ど','な','に','ぬ','ね','の','は','ば','ぱ','ひ','び','ぴ','ふ','ぶ','ぷ','へ','べ','ぺ','ほ','ぼ','ぽ','ま','み','む','め','も','ゃ','や','ゅ','ゆ','ょ','よ','ら','り','る','れ','ろ','ゎ','わ','ゐ','ゑ','を','ん','ゔ','ゕ','ゟ','亜','哀','挨','愛','曖','悪','握','圧','扱','宛','嵐','安','案','暗','以','衣','位','囲','医','依','委','威','為','畏','胃','尉','異','移','萎','偉','椅','彙','意','違','維','慰','遺','緯','域','育','壱','逸','茨','芋','引','印','因','咽','姻','員','院','淫','陰','飲','隠','韻','右','宇','羽','雨','唄','鬱','畝','浦','運','雲','永','泳','英','映','栄','営','詠','影','鋭','衛','易','疫','益','液','駅','悦','越','謁','閲','円','延','沿','炎','怨','宴','媛','援','園','煙','猿','遠','鉛','塩','演','縁','艶','汚','王','凹','央','応','往','押','旺','欧','殴','桜','翁','奥','横','岡','屋','億','憶','臆','虞','乙','俺','卸','音','恩','温','穏','下','化','火','加','可','仮','何','花','佳','価','果','河','苛','科'];

								message.content = message.content.substr(vapor[0].length, message.content.length)
									.replace("", "「")
                                    .replace(/[ ]/g,'　')
                                    .replace(/[a]/g,'ａ')
                                    .replace(/[b]/g,'ｂ')
                                    .replace(/[c]/g,'ｃ')
                                    .replace(/[d]/g,'ｄ')
                                    .replace(/[e]/g,'ｅ')
                                    .replace(/[f]/g,'ｆ')
                                    .replace(/[g]/g,'ｇ')
                                    .replace(/[h]/g,'ｈ')
                                    .replace(/[i]/g,'ｉ')
                                    .replace(/[j]/g,'ｊ')
                                    .replace(/[k]/g,'ｋ')
                                    .replace(/[l]/g,'ｌ')
                                    .replace(/[m]/g,'ｍ')
                                    .replace(/[n]/g,'ｎ')
                                    .replace(/[o]/g,'ｏ')
                                    .replace(/[p]/g,'ｐ')
                                    .replace(/[q]/g,'ｑ')
                                    .replace(/[r]/g,'ｒ')
                                    .replace(/[s]/g,'ｓ')
                                    .replace(/[t]/g,'ｔ')
                                    .replace(/[u]/g,'ｕ')
                                    .replace(/[v]/g,'ｖ')
                                    .replace(/[w]/g,'ｗ')
                                    .replace(/[x]/g,'ｘ')
                                    .replace(/[y]/g,'ｙ')
                                    .replace(/[z]/g,'ｚ')
                                    .replace(/[A]/g,'Ａ')
                                    .replace(/[B]/g,'Ｂ')
                                    .replace(/[C]/g,'Ｃ')
                                    .replace(/[D]/g,'Ｄ')
                                    .replace(/[E]/g,'Ｅ')
                                    .replace(/[F]/g,'Ｆ')
                                    .replace(/[G]/g,'Ｇ')
                                    .replace(/[H]/g,'Ｈ')
                                    .replace(/[I]/g,'Ｉ')
                                    .replace(/[J]/g,'Ｊ')
                                    .replace(/[K]/g,'Ｋ')
                                    .replace(/[L]/g,'Ｌ')
                                    .replace(/[M]/g,'Ｍ')
                                    .replace(/[N]/g,'Ｎ')
                                    .replace(/[O]/g,'Ｏ')
                                    .replace(/[P]/g,'Ｐ')
                                    .replace(/[Q]/g,'Ｑ')
                                    .replace(/[R]/g,'Ｒ')
                                    .replace(/[S]/g,'Ｓ')
                                    .replace(/[T]/g,'Ｔ')
                                    .replace(/[U]/g,'Ｕ')
                                    .replace(/[V]/g,'Ｖ')
                                    .replace(/[W]/g,'Ｗ')
                                    .replace(/[X]/g,'Ｘ')
                                    .replace(/[Y]/g,'Ｙ')
                                    .replace(/[Z]/g,'Ｚ')
                                    .replace(/[0]/g,'０')
                                    .replace(/[1]/g,'１')
                                    .replace(/[2]/g,'２')
                                    .replace(/[3]/g,'３')
                                    .replace(/[4]/g,'４')
                                    .replace(/[5]/g,'５')
                                    .replace(/[6]/g,'６')
                                    .replace(/[7]/g,'７')
                                    .replace(/[8]/g,'８')
                                    .replace(/[9]/g,'９')
                                    .replace(/[\`]/g,'｀')
                                    .replace(/[!]/g,'！')
                                    .replace(/["]/g,'＂')
                                    .replace(/[\$]/g,'＄')
                                    .replace(/[%]/g,'％')
                                    .replace(/[\^]/g,'＾')
                                    .replace(/[&]/g,'＆')
                                    .replace(/[*]/g,'＊')
                                    .replace(/[(]/g,'（')
                                    .replace(/[)]/g,'）')
                                    .replace(/[_]/g,'＿')
                                    .replace(/[+]/g,'＋')
                                    .replace(/[-]/g,'－')
                                    .replace(/[=]/g,'＝')
                                    .replace(/[\[]/g,'［')
                                    .replace(/[\]]/g,'］')
                                    .replace(/[\{]/g,'｛')
                                    .replace(/[\}]/g,'｝')
                                    .replace(/[;]/g,'；')
                                    .replace(/[']/g,'＇')
                                    .replace(/[#]/g,'＃')
                                    .replace(/[:]/g,'：')
                                    .replace(/[@]/g,'＠')
                                    .replace(/[~]/g,'～')
                                    .replace(/[,]/g,'，')
                                    .replace(/[.]/g,'．')
                                    .replace(/[/]/g,'／')
                                    .replace(/[<]/g,'＜')
                                    .replace(/[>]/g,'＞')
                                    .replace(/[?]/g,'？')
                                    .replace(/[\\]/g,'＼')
                                    .replace(/[|]/g,'｜')
									+ " " + "」" + japanese[404 * Math.random() << 0] + japanese[404 * Math.random() << 0] + japanese[404 * Math.random() << 0];

								break;
                                
                            case "square":
								const square = (/^square\$ /g).exec(content);

								message.content = message.content.substr(square[0].length, message.content.length)
                                    .toLowerCase()
                                    .replace(/[a]/g, '🅰 ')
                                    .replace(/[b]/g, '🅱 ')
                                    .replace(/[c]/g, '🅲 ')
                                    .replace(/[d]/g, '🅳 ')
                                    .replace(/[e]/g, '🅴 ')
                                    .replace(/[f]/g, '🅵 ')
                                    .replace(/[g]/g, '🅶 ')
                                    .replace(/[h]/g, '🅷 ')
                                    .replace(/[i]/g, '🅸 ')
                                    .replace(/[j]/g, '🅹 ')
                                    .replace(/[k]/g, '🅺 ')
                                    .replace(/[l]/g, '🅻 ')
                                    .replace(/[m]/g, '🅼 ')
                                    .replace(/[n]/g, '🅽 ')
                                    .replace(/[o]/g, '🅾 ')
                                    .replace(/[p]/g, '🅿 ')
                                    .replace(/[q]/g, '🆀 ')
                                    .replace(/[r]/g, '🆁 ')
                                    .replace(/[s]/g, '🆂 ')
                                    .replace(/[t]/g, '🆃 ')
                                    .replace(/[u]/g, '🆄 ')
                                    .replace(/[v]/g, '🆅 ')
                                    .replace(/[w]/g, '🆆 ')
                                    .replace(/[x]/g, '🆇 ')
                                    .replace(/[y]/g, '🆈 ')
                                    .replace(/[z]/g, '🆉 ')
                                    .replace(/[?]/g, '❓ ')
                                    .replace(/[!]/g, '❗ '); 

								break;
						}
					});
				}
	
				onStop()
				{
					Patcher.unpatchAll();
				}
			}
		};

        return plugin(Plugin, Api);
    })(global.ZeresPluginLibrary.buildPlugin(config));
})();
