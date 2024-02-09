uartm_write_128     (.addr(GPCFG_N_ADDR[0]),        .data(128'd340282366920938463463374607431768211455)); 
uartm_write_128     (.addr(GPCFG_NINV_ADDR[0]),     .data(128'd94479205471584908078512164688757288992)); 
uartm_write_256     (.addr(GPCFG_NSQ_ADDR[0]),      .data(256'd340282366920938463463374607431768211456)); 
uartm_write         (.addr(GPCFG_NSQ_ADDR[5]),      .data(32'd256)); 
coef[0]  = 128'd5427561963718364226968611699316149467;
coef[1]  = 128'd27419782918873199598517159992664356067;
coef[2]  = 128'd75103119605232812118781681508315480255;
coef[3]  = 128'd287403655994602376031718440798840486621;
coef[4]  = 128'd154967214988861469469121948777950593247;
coef[5]  = 128'd123761457086493720133769699233676532221;
coef[6]  = 128'd166215536530195252474655430968398476125;
coef[7]  = 128'd231460282110959343272148430916936023971;
coef[8]  = 128'd193961657963098920634223617812249935466;
coef[9]  = 128'd218545936849555037531445370432569441245;
coef[10]  = 128'd240726299385686474919023950104970078678;
coef[11]  = 128'd8241950384565467643239402734143056551;
coef[12]  = 128'd226600280664362256312286113295556099051;
coef[13]  = 128'd7462347244725168131891616430353648445;
coef[14]  = 128'd216102643317324428413903817981276335066;
coef[15]  = 128'd192784206196642508676326298923052229241;
coef[16]  = 128'd195334009167758530540400303911326939922;
coef[17]  = 128'd297919715475609774921780718564354254561;
coef[18]  = 128'd218504008092285244703569584923562441346;
coef[19]  = 128'd59304772154591038599665717387972174045;
coef[20]  = 128'd155359676746631635009550505147809854066;
coef[21]  = 128'd138245504546189925112775094651782966836;
coef[22]  = 128'd123154679849056547934891668922597826625;
coef[23]  = 128'd322313015264843168147955796508229127729;
coef[24]  = 128'd164716264469385029560734633993769325590;
coef[25]  = 128'd46848323508636153382174340137720663346;
coef[26]  = 128'd311788249476638282360291728310777727816;
coef[27]  = 128'd291554027447555046426634386810692010377;
coef[28]  = 128'd279814802351524727157893896825934790463;
coef[29]  = 128'd65539500872599976371156133038725878503;
coef[30]  = 128'd49881996254035481571146625384813703403;
coef[31]  = 128'd316275173385618287487938745413301966835;
coef[32]  = 128'd135540901333008232969275873857270275921;
coef[33]  = 128'd4305942569268880956276066487702897109;
coef[34]  = 128'd190258736013456692600315107162897981145;
coef[35]  = 128'd74079977214586996132421165577492066186;
coef[36]  = 128'd97371058854449997833981488779309815569;
coef[37]  = 128'd85201318678882992718852801649962430468;
coef[38]  = 128'd291275510543447430299407076419386781938;
coef[39]  = 128'd265681295431576362182731142253835872979;
coef[40]  = 128'd163633883829106023382321020312706708294;
coef[41]  = 128'd21532765487306523421053761559657124168;
coef[42]  = 128'd220969487746603053750591245687734946700;
coef[43]  = 128'd226807586507468465125217196790133120981;
coef[44]  = 128'd329438526211535694303329826275950075871;
coef[45]  = 128'd105466255288186254828955135585468724507;
coef[46]  = 128'd307999124122336929547380261988697944216;
coef[47]  = 128'd118835157271640965480448307782002915022;
coef[48]  = 128'd76423123932472644528821383261522949355;
coef[49]  = 128'd229358331078297155337430334597565815467;
coef[50]  = 128'd40794402806437952258378468343687695280;
coef[51]  = 128'd154388630985294198853301017418405680467;
coef[52]  = 128'd39208723646274387363013372577970850781;
coef[53]  = 128'd251050339379066766693071742323675241751;
coef[54]  = 128'd118520156606998955265653775536679004781;
coef[55]  = 128'd88358373201291666968597186580653710239;
coef[56]  = 128'd76656267989206922675994633804232170489;
coef[57]  = 128'd248630132502667898983249525843427369622;
coef[58]  = 128'd167413036189418933199598412841261551263;
coef[59]  = 128'd174426611931793345663739873451580669192;
coef[60]  = 128'd106719135892957737202768118487305984719;
coef[61]  = 128'd92264807938757875526962589014700797360;
coef[62]  = 128'd107742426696883347706654142550477195559;
coef[63]  = 128'd101692598543450888677627854990129774839;
coef[64]  = 128'd268072691377250735201607339014524026547;
coef[65]  = 128'd32690368348637779896759022035234873199;
coef[66]  = 128'd215734887016229177160525209142072287213;
coef[67]  = 128'd311075870698951335386301306418751546914;
coef[68]  = 128'd148610287761007364467210281576275501479;
coef[69]  = 128'd110490503158256275578124466127784824727;
coef[70]  = 128'd37481724812624456010501948080837678918;
coef[71]  = 128'd60752802389758642759132139734076726199;
coef[72]  = 128'd307795857278282705430366104658232509424;
coef[73]  = 128'd235592889130935525926102805699777782177;
coef[74]  = 128'd322854156637717967511514544897317130433;
coef[75]  = 128'd156357924201251037123503516954064279539;
coef[76]  = 128'd298470316405165407434400287276737960883;
coef[77]  = 128'd319109388113237970157072747186286967390;
coef[78]  = 128'd140354979140762059241835858855698629787;
coef[79]  = 128'd308369887262910626863957047084317091974;
coef[80]  = 128'd60810760667485346634228901504017573910;
coef[81]  = 128'd330351463819355676139008215201053796121;
coef[82]  = 128'd132906641373344089647497801105638202642;
coef[83]  = 128'd116981383070158455710243202038396594192;
coef[84]  = 128'd222968596277978835410655660288777965816;
coef[85]  = 128'd307588644476316276414175633265206299710;
coef[86]  = 128'd210076362227858200908050106645037027903;
coef[87]  = 128'd61361848548346152650245760609336420128;
coef[88]  = 128'd212282301414157926811673581239840052348;
coef[89]  = 128'd56777312130098596716513885064548548503;
coef[90]  = 128'd71899673813956674341488352873064967088;
coef[91]  = 128'd306737398200864109756499072732090102473;
coef[92]  = 128'd327446685822177924794579234325326732378;
coef[93]  = 128'd58454306954344540103129768377330862537;
coef[94]  = 128'd179878988671080994359443407953513247570;
coef[95]  = 128'd296732311675905625641825750649131123520;
coef[96]  = 128'd225229867543003442408568109717510648771;
coef[97]  = 128'd168542275094955838424498688347882176405;
coef[98]  = 128'd144143458111046793071810631885932561089;
coef[99]  = 128'd17987478239776662430473304968397491519;
coef[100]  = 128'd19590585876785126596330485558763135684;
coef[101]  = 128'd277350658627122667843792292781722793512;
coef[102]  = 128'd233150734298610454232200411256668152482;
coef[103]  = 128'd17701245798299798863481128044366446549;
coef[104]  = 128'd3093177329815417441885070839869731211;
coef[105]  = 128'd336811686729887660986510496772671094793;
coef[106]  = 128'd172151975352953892043278443426262911735;
coef[107]  = 128'd130110998939705310499224121910975361421;
coef[108]  = 128'd22703691585224774231455024250465610381;
coef[109]  = 128'd129512217171505907512124934848462906975;
coef[110]  = 128'd34023544598182457359785361304157490154;
coef[111]  = 128'd18610901089050196702223613264039653379;
coef[112]  = 128'd264830312617660889047943207292356270610;
coef[113]  = 128'd160016766728762757338407137996060467481;
coef[114]  = 128'd150576693894096301814279917756710543218;
coef[115]  = 128'd13722156682909052847004943216438304624;
coef[116]  = 128'd105536681286089197879987820795824447736;
coef[117]  = 128'd184389247237264837916573734737143938202;
coef[118]  = 128'd333784334006152259071388788824581704966;
coef[119]  = 128'd275306223804301084392999115764897972259;
coef[120]  = 128'd107949001691313673441297358283297857349;
coef[121]  = 128'd251932806672582911239883156902462554771;
coef[122]  = 128'd181368676464509745823140692314619086413;
coef[123]  = 128'd203375495849543498377203328500820876483;
coef[124]  = 128'd210074910654592071691305146270391043342;
coef[125]  = 128'd49458945513767787432970288950838654027;
coef[126]  = 128'd152576269184857354334765781797592116074;
coef[127]  = 128'd284351116387233471283488310089188434793;
coef[128]  = 128'd2166470896748002579300878388705232909;
coef[129]  = 128'd264686855120000062717086870634730996927;
coef[130]  = 128'd124734911821360293886137920978933482133;
coef[131]  = 128'd127861277124468534368250326420038955827;
coef[132]  = 128'd265180978259401188258544450958033876180;
coef[133]  = 128'd20957957048025670727867791782768292519;
coef[134]  = 128'd277241116875948979973693748443266027055;
coef[135]  = 128'd235899796491872548855885821381428525301;
coef[136]  = 128'd292715981326687198509030243477053653346;
coef[137]  = 128'd163263779651429576134789808517494998996;
coef[138]  = 128'd219137758374255134798929109263456588449;
coef[139]  = 128'd104712794462499678775778451798965990380;
coef[140]  = 128'd198969586477075224325520760757433859056;
coef[141]  = 128'd17897375443541928435591510135703732396;
coef[142]  = 128'd122399718355288393192955697648597630561;
coef[143]  = 128'd224870666215089726498786910982585349071;
coef[144]  = 128'd229635053895162417807674658731698365170;
coef[145]  = 128'd95373561283806312865844076083004980124;
coef[146]  = 128'd211510960057841563971586210962912054823;
coef[147]  = 128'd70136452687180357527446987022699788075;
coef[148]  = 128'd50029537615245764278507880012873177899;
coef[149]  = 128'd196152233050641412988064208009258393996;
coef[150]  = 128'd165651439080612168756256681874422850065;
coef[151]  = 128'd22417938952964893163934692939973681107;
coef[152]  = 128'd295959647802643991480687882756038314342;
coef[153]  = 128'd95867001248254782687693253698223141011;
coef[154]  = 128'd279776702742773036565070270270191734389;
coef[155]  = 128'd246995668553277151784112069755075988345;
coef[156]  = 128'd242645378471484158078216705891187130681;
coef[157]  = 128'd34089744903018914682649531587302698526;
coef[158]  = 128'd108096456128745128137187214504506429962;
coef[159]  = 128'd159853135843641091748371214230021260706;
coef[160]  = 128'd95985165061511177947798405253938478879;
coef[161]  = 128'd217704693594373731323554584260576897556;
coef[162]  = 128'd327256132178463862524059680431978462875;
coef[163]  = 128'd91777758702951439309711023098176691047;
coef[164]  = 128'd94191816158749982928641696883662558372;
coef[165]  = 128'd272519616929619851281259232956106914803;
coef[166]  = 128'd10425768597143147055225078677220143705;
coef[167]  = 128'd336933155749490273807466139757572986480;
coef[168]  = 128'd129478368986338295596554428596485457042;
coef[169]  = 128'd290261626478922170446660603858068637958;
coef[170]  = 128'd140466536043129750813611070384899465713;
coef[171]  = 128'd300568501147007400607693203222088604114;
coef[172]  = 128'd328048699313386653733437367978865138440;
coef[173]  = 128'd291200357528143513001309582996945328406;
coef[174]  = 128'd299059182084252889979672597809762782037;
coef[175]  = 128'd120282140353651749074472895166858151611;
coef[176]  = 128'd205338289268855491213254654705513367871;
coef[177]  = 128'd56558152570618536517898632693399892670;
coef[178]  = 128'd240536675018678574676168582052056706683;
coef[179]  = 128'd90463873899903397347252395645987855896;
coef[180]  = 128'd30062430596187677842081279770193102604;
coef[181]  = 128'd22612847571198563542972739363307242710;
coef[182]  = 128'd212994895161390014314291474727463656084;
coef[183]  = 128'd316513235128735273193812015190995914509;
coef[184]  = 128'd203940789506533695920688618648644493807;
coef[185]  = 128'd118875593770526580666747365547256263981;
coef[186]  = 128'd154881525512847885917692937118351493043;
coef[187]  = 128'd35861269280961850926620715871408847735;
coef[188]  = 128'd175196046461494886368860431649449897045;
coef[189]  = 128'd90901547068031136704024867051181748171;
coef[190]  = 128'd204916116122718458188180928002934696344;
coef[191]  = 128'd153057659653830997300671182238873790389;
coef[192]  = 128'd35390511211363289214144808583106859821;
coef[193]  = 128'd232221476500094445872377977985035633161;
coef[194]  = 128'd154809402774318642240216091314010636885;
coef[195]  = 128'd243485056784132067402089191394499323565;
coef[196]  = 128'd105827901558911356286725364974612816344;
coef[197]  = 128'd298095233199060621688972931634458624444;
coef[198]  = 128'd77602049389398480474928865890832185514;
coef[199]  = 128'd331761978156485591883329361915950025519;
coef[200]  = 128'd87230899393103698641050925621217179360;
coef[201]  = 128'd237050946418931156779764174913883184695;
coef[202]  = 128'd58920799785799693992946449378605184254;
coef[203]  = 128'd123436215826594340305952605749775962251;
coef[204]  = 128'd336895105491103464649905018998487431201;
coef[205]  = 128'd181131716137497849932228343460180991979;
coef[206]  = 128'd24283498027409756514079005409151411710;
coef[207]  = 128'd203600449589026606366369893672015881179;
coef[208]  = 128'd167760704087721861749273042778945406284;
coef[209]  = 128'd315660120871323575413068520565524798688;
coef[210]  = 128'd129722138890160501316918933583510349837;
coef[211]  = 128'd57625328224972296417561016415264122960;
coef[212]  = 128'd324930385252621607915836930661846864723;
coef[213]  = 128'd67918129294527456860644868000130495247;
coef[214]  = 128'd160107399339434276427334906979695966667;
coef[215]  = 128'd211179465368025181297098504431647576157;
coef[216]  = 128'd121614569708435979276306531724368295946;
coef[217]  = 128'd135077393587852061003948819840706937351;
coef[218]  = 128'd306625979451484897233304315782440476813;
coef[219]  = 128'd155832686522676715463670192418074840982;
coef[220]  = 128'd52228090014726877523231369644850224793;
coef[221]  = 128'd105964595995436062065979648739308201985;
coef[222]  = 128'd312562283098673542892431574608748809776;
coef[223]  = 128'd115967931946622035151744979379995193360;
coef[224]  = 128'd114181964005589592761803610785703507730;
coef[225]  = 128'd153246748743974964017771345315357343703;
coef[226]  = 128'd62400296272189609847032557152611898579;
coef[227]  = 128'd282380161251812557605198590255467983123;
coef[228]  = 128'd295167984437118243604175479085984511064;
coef[229]  = 128'd188571123257391125205882584978806228635;
coef[230]  = 128'd148255596220449319284254805861760662231;
coef[231]  = 128'd32587213870807495115064116547668000159;
coef[232]  = 128'd221918377410942048432588428564221185960;
coef[233]  = 128'd193145880565643118719089141277048299333;
coef[234]  = 128'd277429461346487525260036514049441782020;
coef[235]  = 128'd74686773831116844707573022723338418;
coef[236]  = 128'd67585219412967701497162233954235777036;
coef[237]  = 128'd85312926341182945980668005032016989915;
coef[238]  = 128'd12309177825061157285609779412590219885;
coef[239]  = 128'd281348638454335777513549624979081047617;
coef[240]  = 128'd317457933036979386038438713735502193853;
coef[241]  = 128'd74848065107842024753932313149802613223;
coef[242]  = 128'd157499941445247587250180161907945027993;
coef[243]  = 128'd60352745419744154173508039822888808853;
coef[244]  = 128'd117799881619870933282192292803698432028;
coef[245]  = 128'd216397680856584208505956263436658466111;
coef[246]  = 128'd87822036151219786768190481293329818588;
coef[247]  = 128'd284286915944290576635358900293266358411;
coef[248]  = 128'd268108302981034854745158962505504073100;
coef[249]  = 128'd147998423376453459424985039819991551982;
coef[250]  = 128'd157338425847708829375751816296038459478;
coef[251]  = 128'd227181648700608114436246149065624100553;
coef[252]  = 128'd224780933680179159137347404986317508935;
coef[253]  = 128'd258647968745445292841959544356666959376;
coef[254]  = 128'd157262410766439817899158017503654494954;
coef[255]  = 128'd184518816721283020500390700381311963080;
for (i = 0; i < POLYDEG; i++) begin
  uartm_write_128     (.addr(FHEMEM2_BASE + 16*i),  .data(coef[i]));
end
uartm_write         (.addr(GPCFG_FHECTL2),      .data({FHEMEM6_BASE[31:24], FHEMEM2_BASE[31:24], FHEMEM5_BASE[31:24], FHEMEM2_BASE[31:24]}));
uartm_write         (.addr(GPCFG_FHECTL_ADDR),  .data({8'h00, 8'h00, POLYDEG[15:0]}));
uartm_write         (.addr(GPCFG_FHECTLP_ADDR),  .data(32'd32));
fhe_exp_res[0] = 128'd278626357164624876665083113814663031904;
fhe_exp_res[1] = 128'd217060863935567132437879409967476890159;
fhe_exp_res[2] = 128'd196643895943651110359788728858517359920;
fhe_exp_res[3] = 128'd5140127390261263255575781178916726042;
fhe_exp_res[4] = 128'd237048267755007931815716700315743102514;
fhe_exp_res[5] = 128'd48771347146073077374994547989474189862;
fhe_exp_res[6] = 128'd14970455396552386120575669041984095280;
fhe_exp_res[7] = 128'd96026447646911915046235717474221624702;
fhe_exp_res[8] = 128'd142649572879290678399742632206086542807;
fhe_exp_res[9] = 128'd290229553989777004422692548995189608180;
fhe_exp_res[10] = 128'd18262972531443159898118015512392479986;
fhe_exp_res[11] = 128'd177986737196795456594950178747530255642;
fhe_exp_res[12] = 128'd310436546524063338097893529779665625857;
fhe_exp_res[13] = 128'd243193383540963957531666282334457812780;
fhe_exp_res[14] = 128'd200460288339233673966070689225929746687;
fhe_exp_res[15] = 128'd320553204619326891895775556853008915242;
fhe_exp_res[16] = 128'd24434526860563903912768706868645235564;
fhe_exp_res[17] = 128'd58779315942982752987114407671880198127;
fhe_exp_res[18] = 128'd184454396401006911856438179483104831347;
fhe_exp_res[19] = 128'd244381937723359561284600754378924542890;
fhe_exp_res[20] = 128'd338779029611151121978503266756377941262;
fhe_exp_res[21] = 128'd310608351813613079370317711176546630147;
fhe_exp_res[22] = 128'd333178953476553212969613553303057920515;
fhe_exp_res[23] = 128'd322239354951189852137526394478444725753;
fhe_exp_res[24] = 128'd76230185779581205076701903132662772240;
fhe_exp_res[25] = 128'd221492580200312324478531592419316400777;
fhe_exp_res[26] = 128'd309543703961632452309886247462129215842;
fhe_exp_res[27] = 128'd73112328704838821487308975450977315799;
fhe_exp_res[28] = 128'd17687098777865418220359820964068998181;
fhe_exp_res[29] = 128'd204308655687009990359632936412008588621;
fhe_exp_res[30] = 128'd196908924995055572070758665390299533621;
fhe_exp_res[31] = 128'd126031513431457973933897202397785510700;
fhe_exp_res[32] = 128'd145620506696621161776664295941090138882;
fhe_exp_res[33] = 128'd99458576820292845894686521382512943273;
fhe_exp_res[34] = 128'd119116894607609615133117150756323671745;
fhe_exp_res[35] = 128'd219898313518757703108813223801133335122;
fhe_exp_res[36] = 128'd107316369011126798783945760174236107693;
fhe_exp_res[37] = 128'd133825486934995296354023115167666634131;
fhe_exp_res[38] = 128'd245227423312337006141711090063539489311;
fhe_exp_res[39] = 128'd290398768235425510594168654837961323783;
fhe_exp_res[40] = 128'd35418347602927760162862201308561209183;
fhe_exp_res[41] = 128'd227173250101010094238378769312808771646;
fhe_exp_res[42] = 128'd183036879665588216889866874749992987020;
fhe_exp_res[43] = 128'd56123760724736130026641608247216887692;
fhe_exp_res[44] = 128'd145655562563593122889231829186052274532;
fhe_exp_res[45] = 128'd31329476949428039850480411377482430144;
fhe_exp_res[46] = 128'd220467949105945081505043726283189776472;
fhe_exp_res[47] = 128'd271885213400745431653187174362575587279;
fhe_exp_res[48] = 128'd49286087626300610834934637475345598150;
fhe_exp_res[49] = 128'd242016015385547627252911688881611375214;
fhe_exp_res[50] = 128'd23934158730755506019346916226813843880;
fhe_exp_res[51] = 128'd48784016624095223926829222507651860284;
fhe_exp_res[52] = 128'd165693896389404145755190400228055223532;
fhe_exp_res[53] = 128'd35102098549144862416463044026194788222;
fhe_exp_res[54] = 128'd333342840836661579706186354981438289117;
fhe_exp_res[55] = 128'd83838656037772758723594382402643117793;
fhe_exp_res[56] = 128'd128995086979824037393920261140202102933;
fhe_exp_res[57] = 128'd94389592738826968564519668989450072694;
fhe_exp_res[58] = 128'd185154360071915495268211173413872338496;
fhe_exp_res[59] = 128'd28776027154040016692665747898989804339;
fhe_exp_res[60] = 128'd141798345917564258598734931258462908908;
fhe_exp_res[61] = 128'd327760081502920234857241682568042378775;
fhe_exp_res[62] = 128'd273281075144124108562948297275055939693;
fhe_exp_res[63] = 128'd44355108780233192435905143671581848458;
fhe_exp_res[64] = 128'd313272096028616491663918588299628126174;
fhe_exp_res[65] = 128'd200059140759253062456218852895943116673;
fhe_exp_res[66] = 128'd5675306413650993481806469282927986881;
fhe_exp_res[67] = 128'd306227768478445116213794084422744504978;
fhe_exp_res[68] = 128'd74553854013071612423385008662952164378;
fhe_exp_res[69] = 128'd98309706421478234998392550718508418639;
fhe_exp_res[70] = 128'd183964063625912442008309157586262521751;
fhe_exp_res[71] = 128'd276319824435484910266865983765512238218;
fhe_exp_res[72] = 128'd5121701207783496999499002205236567778;
fhe_exp_res[73] = 128'd263283833502912546649473731602034128784;
fhe_exp_res[74] = 128'd261235240441641614644590172675895386311;
fhe_exp_res[75] = 128'd313103466323214329091607108446417338933;
fhe_exp_res[76] = 128'd38626165950703966668180175291732350401;
fhe_exp_res[77] = 128'd260572020804666208325028913803041799540;
fhe_exp_res[78] = 128'd147716575220874402845827426899055769879;
fhe_exp_res[79] = 128'd77262339337622862914540764423441950998;
fhe_exp_res[80] = 128'd239723280717629546268933842487476490340;
fhe_exp_res[81] = 128'd208747078729136661482548579079112496707;
fhe_exp_res[82] = 128'd63281116165834539153101278855341127934;
fhe_exp_res[83] = 128'd213625901157491826086827108032862651979;
fhe_exp_res[84] = 128'd116048803515698293132594151176300472717;
fhe_exp_res[85] = 128'd297553294550017737335050624538126037635;
fhe_exp_res[86] = 128'd216230672327341569528951853328191211776;
fhe_exp_res[87] = 128'd300824532852003711467575624107392388061;
fhe_exp_res[88] = 128'd279521374634345973921512020074135522841;
fhe_exp_res[89] = 128'd245902090028293320054438582835238264491;
fhe_exp_res[90] = 128'd38708631240026026458480287308059493151;
fhe_exp_res[91] = 128'd250559388081755093816801807543090673001;
fhe_exp_res[92] = 128'd33475556173673121478044890438099068136;
fhe_exp_res[93] = 128'd209620399029140656872143574877253843054;
fhe_exp_res[94] = 128'd127707973756450057030611846340051216945;
fhe_exp_res[95] = 128'd265917910158872760387550355335597182835;
fhe_exp_res[96] = 128'd322513868678430559502630015505945005092;
fhe_exp_res[97] = 128'd592534648280305123648000020058539940;
fhe_exp_res[98] = 128'd223356831308414722273752992984015209303;
fhe_exp_res[99] = 128'd256928339333844729830213406007777072848;
fhe_exp_res[100] = 128'd206808859134750156588599479539506822308;
fhe_exp_res[101] = 128'd225542154407637818213168900363400565529;
fhe_exp_res[102] = 128'd311246119614350283786958318603652491394;
fhe_exp_res[103] = 128'd102274442229061126204930980456986410673;
fhe_exp_res[104] = 128'd70735226754150373946194670371741673982;
fhe_exp_res[105] = 128'd325272648434483512753041231874973802931;
fhe_exp_res[106] = 128'd224795037277551632914327628229553695785;
fhe_exp_res[107] = 128'd187450718884282460838453539346599213287;
fhe_exp_res[108] = 128'd330989535030396636845804912842159809657;
fhe_exp_res[109] = 128'd76488535158127307554911476133492138710;
fhe_exp_res[110] = 128'd241152164615875521465711830228627509433;
fhe_exp_res[111] = 128'd36762022761899718805372895309835926883;
fhe_exp_res[112] = 128'd91067962164479251402414871317042206555;
fhe_exp_res[113] = 128'd193073560046239840022586103391100334077;
fhe_exp_res[114] = 128'd168555594231188062978064255773822841921;
fhe_exp_res[115] = 128'd212253177963568296023600353278348021093;
fhe_exp_res[116] = 128'd22181016378279116896860402260237514662;
fhe_exp_res[117] = 128'd61074830060222291204905489063231339754;
fhe_exp_res[118] = 128'd143700795463294303672410853720692483262;
fhe_exp_res[119] = 128'd19304611477682904008116850623044583;
fhe_exp_res[120] = 128'd258094450945014371519929275003847599558;
fhe_exp_res[121] = 128'd150059429782092247896007836684371005302;
fhe_exp_res[122] = 128'd159213836419841131267793172515226429531;
fhe_exp_res[123] = 128'd117474862414868224557851386819272512716;
fhe_exp_res[124] = 128'd270317298138160738683484649241794588194;
fhe_exp_res[125] = 128'd252761239180893970789987237080915008614;
fhe_exp_res[126] = 128'd221451442690648781641638276319603947343;
fhe_exp_res[127] = 128'd2017652168253068087705816471655878786;
fhe_exp_res[128] = 128'd179913113565450583078773738608872381883;
fhe_exp_res[129] = 128'd285758219208303959593481168225632945424;
fhe_exp_res[130] = 128'd121499135648154965639019488435168004056;
fhe_exp_res[131] = 128'd123761171847804704644668945012889237639;
fhe_exp_res[132] = 128'd202325997536214121338542772775600619540;
fhe_exp_res[133] = 128'd175983988924876106884489275383201920888;
fhe_exp_res[134] = 128'd15304365718280956842339558197270342225;
fhe_exp_res[135] = 128'd132028832095757682343605675124553228097;
fhe_exp_res[136] = 128'd211971375172434364313228526739922863442;
fhe_exp_res[137] = 128'd289912153049572187225607985478913341437;
fhe_exp_res[138] = 128'd84219391552782931797650602781574460758;
fhe_exp_res[139] = 128'd89469177114123357997327599038176413310;
fhe_exp_res[140] = 128'd93838093928268229903993248819781141322;
fhe_exp_res[141] = 128'd120590889833553534266200295327420105677;
fhe_exp_res[142] = 128'd313582212493274251454405591949078948897;
fhe_exp_res[143] = 128'd126003102046847990497997346743073475637;
fhe_exp_res[144] = 128'd240950972791306507071771081274544532830;
fhe_exp_res[145] = 128'd313147240964826847701791607370026762378;
fhe_exp_res[146] = 128'd7243009564909130243595295437677967781;
fhe_exp_res[147] = 128'd297526341665060269471952618290412132840;
fhe_exp_res[148] = 128'd136168604782927957287883705619050839718;
fhe_exp_res[149] = 128'd176180789232532632874358264905850291152;
fhe_exp_res[150] = 128'd231065073169466556373753235600573691550;
fhe_exp_res[151] = 128'd261696811983748793761736412219904878539;
fhe_exp_res[152] = 128'd248014566539112348170760498152143682049;
fhe_exp_res[153] = 128'd270223777962711308098983126462177760737;
fhe_exp_res[154] = 128'd272994771277951122179467459840547384443;
fhe_exp_res[155] = 128'd113222858737840814483302645015325276175;
fhe_exp_res[156] = 128'd85986356371620486684010870929804257647;
fhe_exp_res[157] = 128'd321545407265922760959450228651469087127;
fhe_exp_res[158] = 128'd21478109693802319750262407960456375114;
fhe_exp_res[159] = 128'd179591307602947536861407963453560409887;
fhe_exp_res[160] = 128'd103541211565633751393577076921103232983;
fhe_exp_res[161] = 128'd331400441244926853737108662137378026667;
fhe_exp_res[162] = 128'd26567284778229462597916663095051095585;
fhe_exp_res[163] = 128'd39644166795755480806923142567130392639;
fhe_exp_res[164] = 128'd276960246638833997759128374432824980004;
fhe_exp_res[165] = 128'd25290566978576178327475297680401407126;
fhe_exp_res[166] = 128'd285487138316667607081535271204329524145;
fhe_exp_res[167] = 128'd277175760717582603349936269582412322205;
fhe_exp_res[168] = 128'd289474975094988319710691729986092498599;
fhe_exp_res[169] = 128'd33416695647401058225461445951191192861;
fhe_exp_res[170] = 128'd311808383625926809542530432808010945351;
fhe_exp_res[171] = 128'd141029116965459917841612697348833775013;
fhe_exp_res[172] = 128'd157713342155165756169153736746791556565;
fhe_exp_res[173] = 128'd328728584790910123163255239073953570657;
fhe_exp_res[174] = 128'd71384154909903589481268488057929358344;
fhe_exp_res[175] = 128'd51170234931408595714850473329250422122;
fhe_exp_res[176] = 128'd176927058886696755353563183602636872432;
fhe_exp_res[177] = 128'd51901533547392107559902289977638273905;
fhe_exp_res[178] = 128'd166137240108778135712189585471732577181;
fhe_exp_res[179] = 128'd47501835298043085279990646151015543812;
fhe_exp_res[180] = 128'd53748498998001865138692778903772235083;
fhe_exp_res[181] = 128'd59983152594787647573950926408911486430;
fhe_exp_res[182] = 128'd142604226761166229150596918275628126608;
fhe_exp_res[183] = 128'd315655045490593322865610383920090206703;
fhe_exp_res[184] = 128'd164818588704586960532073821005575018909;
fhe_exp_res[185] = 128'd272936877250518281552724136902440734137;
fhe_exp_res[186] = 128'd51118596925676605571257426960873635821;
fhe_exp_res[187] = 128'd318861431931700224348469795020605504270;
fhe_exp_res[188] = 128'd282074150558522573322126274912639143545;
fhe_exp_res[189] = 128'd108460220960284376539874006473704684202;
fhe_exp_res[190] = 128'd13526388168754277103240421677775897288;
fhe_exp_res[191] = 128'd55736413488257231729904620991078768078;
fhe_exp_res[192] = 128'd33720630485062160880415851912319172202;
fhe_exp_res[193] = 128'd19927107069537953185937452614173845352;
fhe_exp_res[194] = 128'd151689915922912069893926949989593916635;
fhe_exp_res[195] = 128'd324427845336648060237753783825250492035;
fhe_exp_res[196] = 128'd239080286864137797282620717125767061263;
fhe_exp_res[197] = 128'd108033385335400735226936408771732284133;
fhe_exp_res[198] = 128'd232555842928903828931273283652445635808;
fhe_exp_res[199] = 128'd83510988465836362996672431751052012403;
fhe_exp_res[200] = 128'd174861511601070471139607945746376145780;
fhe_exp_res[201] = 128'd336115490977690921020447351009427640945;
fhe_exp_res[202] = 128'd143788821940855667215714804768429739318;
fhe_exp_res[203] = 128'd339541412033217145427469127744080883262;
fhe_exp_res[204] = 128'd334963054976027019145102173588126294932;
fhe_exp_res[205] = 128'd113617133015169668586173534611567363623;
fhe_exp_res[206] = 128'd21868179009298678083401093858457210445;
fhe_exp_res[207] = 128'd58139111423427163801500731829536256523;
fhe_exp_res[208] = 128'd53958880804846565266154989830659161608;
fhe_exp_res[209] = 128'd317417743974344300556908816031663941051;
fhe_exp_res[210] = 128'd185104047478776221968473809372804805674;
fhe_exp_res[211] = 128'd247532460727344172872804296471780252170;
fhe_exp_res[212] = 128'd310087110124990960886602403264961263756;
fhe_exp_res[213] = 128'd267415850065331352161240230292795876434;
fhe_exp_res[214] = 128'd25125248724633789552590541717483415259;
fhe_exp_res[215] = 128'd18139474034015493699333966403321352144;
fhe_exp_res[216] = 128'd33504125049841507629573058291619327237;
fhe_exp_res[217] = 128'd267075413023263161579450989289449159402;
fhe_exp_res[218] = 128'd71176208611664484180148373333619932251;
fhe_exp_res[219] = 128'd334856088372983197828214137827973921714;
fhe_exp_res[220] = 128'd252353625783374983109480032050697906691;
fhe_exp_res[221] = 128'd324086587949551327374947493033672208430;
fhe_exp_res[222] = 128'd168870505678049509732225392618851530557;
fhe_exp_res[223] = 128'd9774955184910391993609673692004410930;
fhe_exp_res[224] = 128'd119926774362416483156366881675732159200;
fhe_exp_res[225] = 128'd221616369471641335396839111841717090336;
fhe_exp_res[226] = 128'd224367019701305216736511205089286525078;
fhe_exp_res[227] = 128'd46833757980127031080232577188065552356;
fhe_exp_res[228] = 128'd243558591904720450790763260539078162468;
fhe_exp_res[229] = 128'd230505656499370622945360913618352663275;
fhe_exp_res[230] = 128'd150248394338325137484813622006295300442;
fhe_exp_res[231] = 128'd262446460386186447893930049413462158148;
fhe_exp_res[232] = 128'd302515075112022591968163514680931967400;
fhe_exp_res[233] = 128'd130700566951466048943864932330782400746;
fhe_exp_res[234] = 128'd193332594087193909073560703322124242025;
fhe_exp_res[235] = 128'd249425525018329317593586084799532303166;
fhe_exp_res[236] = 128'd229617990738779061196866347163075967462;
fhe_exp_res[237] = 128'd238238640378052965912607847513425080420;
fhe_exp_res[238] = 128'd208138662255574875470800352301220791265;
fhe_exp_res[239] = 128'd43579576818047319942687131374784462409;
fhe_exp_res[240] = 128'd172660647726776308163104583346468868981;
fhe_exp_res[241] = 128'd318601107853696633419644830043528839401;
fhe_exp_res[242] = 128'd130574279150293493475263710541100508281;
fhe_exp_res[243] = 128'd150983275800317169320670102061167085246;
fhe_exp_res[244] = 128'd254021670107483299931834503844467890526;
fhe_exp_res[245] = 128'd31552765583913913915450915366013428362;
fhe_exp_res[246] = 128'd47377122457245195122010157497567638211;
fhe_exp_res[247] = 128'd304636871481458483534104379046287990577;
fhe_exp_res[248] = 128'd78960855667134763246223842560477431195;
fhe_exp_res[249] = 128'd96152796097725953389673559422825911134;
fhe_exp_res[250] = 128'd91882592248887638500173298231226762596;
fhe_exp_res[251] = 128'd22019666845378249296548721754857731146;
fhe_exp_res[252] = 128'd52479113157385631095126953343548785635;
fhe_exp_res[253] = 128'd299542457855364120753893745227315873452;
fhe_exp_res[254] = 128'd59027064753306566062806269169147329348;
fhe_exp_res[255] = 128'd325251099562320263354246790507169136555;