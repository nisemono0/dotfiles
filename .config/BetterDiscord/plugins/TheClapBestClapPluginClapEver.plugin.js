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
									+ " " + ["owo", "OwO", "uwu", "UwU", ">w<", "^w^", "???w???"][7 * Math.random() << 0];

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
									+ " " + ["owo", "OwO", "uwu", "UwU", ">w<", "^w^", "???w???"][7 * Math.random() << 0];

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
                                
                                var japanese = ['???','???','???','???','???','???','???','???','???','???','???','???','???','???','???',' ','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???',' ','-','???','???','???','???','???','???','???','???','???','???','???','???','??????','??????','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','??????','??????','???','???','???','???','???','???','???','??????','???','???','???','???','???','???','??????','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???','???'];

								message.content = message.content.substr(vapor[0].length, message.content.length)
									.replace("", "???")
                                    .replace(/[ ]/g,'???')
                                    .replace(/[a]/g,'???')
                                    .replace(/[b]/g,'???')
                                    .replace(/[c]/g,'???')
                                    .replace(/[d]/g,'???')
                                    .replace(/[e]/g,'???')
                                    .replace(/[f]/g,'???')
                                    .replace(/[g]/g,'???')
                                    .replace(/[h]/g,'???')
                                    .replace(/[i]/g,'???')
                                    .replace(/[j]/g,'???')
                                    .replace(/[k]/g,'???')
                                    .replace(/[l]/g,'???')
                                    .replace(/[m]/g,'???')
                                    .replace(/[n]/g,'???')
                                    .replace(/[o]/g,'???')
                                    .replace(/[p]/g,'???')
                                    .replace(/[q]/g,'???')
                                    .replace(/[r]/g,'???')
                                    .replace(/[s]/g,'???')
                                    .replace(/[t]/g,'???')
                                    .replace(/[u]/g,'???')
                                    .replace(/[v]/g,'???')
                                    .replace(/[w]/g,'???')
                                    .replace(/[x]/g,'???')
                                    .replace(/[y]/g,'???')
                                    .replace(/[z]/g,'???')
                                    .replace(/[A]/g,'???')
                                    .replace(/[B]/g,'???')
                                    .replace(/[C]/g,'???')
                                    .replace(/[D]/g,'???')
                                    .replace(/[E]/g,'???')
                                    .replace(/[F]/g,'???')
                                    .replace(/[G]/g,'???')
                                    .replace(/[H]/g,'???')
                                    .replace(/[I]/g,'???')
                                    .replace(/[J]/g,'???')
                                    .replace(/[K]/g,'???')
                                    .replace(/[L]/g,'???')
                                    .replace(/[M]/g,'???')
                                    .replace(/[N]/g,'???')
                                    .replace(/[O]/g,'???')
                                    .replace(/[P]/g,'???')
                                    .replace(/[Q]/g,'???')
                                    .replace(/[R]/g,'???')
                                    .replace(/[S]/g,'???')
                                    .replace(/[T]/g,'???')
                                    .replace(/[U]/g,'???')
                                    .replace(/[V]/g,'???')
                                    .replace(/[W]/g,'???')
                                    .replace(/[X]/g,'???')
                                    .replace(/[Y]/g,'???')
                                    .replace(/[Z]/g,'???')
                                    .replace(/[0]/g,'???')
                                    .replace(/[1]/g,'???')
                                    .replace(/[2]/g,'???')
                                    .replace(/[3]/g,'???')
                                    .replace(/[4]/g,'???')
                                    .replace(/[5]/g,'???')
                                    .replace(/[6]/g,'???')
                                    .replace(/[7]/g,'???')
                                    .replace(/[8]/g,'???')
                                    .replace(/[9]/g,'???')
                                    .replace(/[\`]/g,'???')
                                    .replace(/[!]/g,'???')
                                    .replace(/["]/g,'???')
                                    .replace(/[\$]/g,'???')
                                    .replace(/[%]/g,'???')
                                    .replace(/[\^]/g,'???')
                                    .replace(/[&]/g,'???')
                                    .replace(/[*]/g,'???')
                                    .replace(/[(]/g,'???')
                                    .replace(/[)]/g,'???')
                                    .replace(/[_]/g,'???')
                                    .replace(/[+]/g,'???')
                                    .replace(/[-]/g,'???')
                                    .replace(/[=]/g,'???')
                                    .replace(/[\[]/g,'???')
                                    .replace(/[\]]/g,'???')
                                    .replace(/[\{]/g,'???')
                                    .replace(/[\}]/g,'???')
                                    .replace(/[;]/g,'???')
                                    .replace(/[']/g,'???')
                                    .replace(/[#]/g,'???')
                                    .replace(/[:]/g,'???')
                                    .replace(/[@]/g,'???')
                                    .replace(/[~]/g,'???')
                                    .replace(/[,]/g,'???')
                                    .replace(/[.]/g,'???')
                                    .replace(/[/]/g,'???')
                                    .replace(/[<]/g,'???')
                                    .replace(/[>]/g,'???')
                                    .replace(/[?]/g,'???')
                                    .replace(/[\\]/g,'???')
                                    .replace(/[|]/g,'???')
									+ " " + "???" + japanese[404 * Math.random() << 0] + japanese[404 * Math.random() << 0] + japanese[404 * Math.random() << 0];

								break;
                                
                            case "square":
								const square = (/^square\$ /g).exec(content);

								message.content = message.content.substr(square[0].length, message.content.length)
                                    .toLowerCase()
                                    .replace(/[a]/g, '???? ')
                                    .replace(/[b]/g, '???? ')
                                    .replace(/[c]/g, '???? ')
                                    .replace(/[d]/g, '???? ')
                                    .replace(/[e]/g, '???? ')
                                    .replace(/[f]/g, '???? ')
                                    .replace(/[g]/g, '???? ')
                                    .replace(/[h]/g, '???? ')
                                    .replace(/[i]/g, '???? ')
                                    .replace(/[j]/g, '???? ')
                                    .replace(/[k]/g, '???? ')
                                    .replace(/[l]/g, '???? ')
                                    .replace(/[m]/g, '???? ')
                                    .replace(/[n]/g, '???? ')
                                    .replace(/[o]/g, '???? ')
                                    .replace(/[p]/g, '???? ')
                                    .replace(/[q]/g, '???? ')
                                    .replace(/[r]/g, '???? ')
                                    .replace(/[s]/g, '???? ')
                                    .replace(/[t]/g, '???? ')
                                    .replace(/[u]/g, '???? ')
                                    .replace(/[v]/g, '???? ')
                                    .replace(/[w]/g, '???? ')
                                    .replace(/[x]/g, '???? ')
                                    .replace(/[y]/g, '???? ')
                                    .replace(/[z]/g, '???? ')
                                    .replace(/[?]/g, '??? ')
                                    .replace(/[!]/g, '??? '); 

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
