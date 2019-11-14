function variable_41 = PredictShift(Inputs)
    
variable_1 = Inputs(1);
variable_2 = Inputs(2);
variable_3 = Inputs(3);
variable_4 = Inputs(4);
variable_5 = Inputs(5);
variable_6 = Inputs(6);
variable_7 = Inputs(7);
variable_8 = Inputs(8);
variable_9 = Inputs(9);
variable_10 = Inputs(10);
variable_11 = Inputs(11);
variable_12 = Inputs(12);
variable_13 = Inputs(13);
variable_14 = Inputs(14);
variable_15 = Inputs(15);
variable_16 = Inputs(16);
variable_17 = Inputs(17);
variable_18 = Inputs(18);
variable_19 = Inputs(19);
variable_20 = Inputs(20);
variable_21 = Inputs(21);
variable_22 = Inputs(22);
variable_23 = Inputs(23);
variable_24 = Inputs(24);
variable_25 = Inputs(25);
variable_26 = Inputs(26);
variable_27 = Inputs(27);
variable_28 = Inputs(28);
variable_29 = Inputs(29);
variable_30 = Inputs(30);
variable_31 = Inputs(31);
variable_32 = Inputs(32);
variable_33 = Inputs(33);
variable_34 = Inputs(34);
variable_35 = Inputs(35);
variable_36 = Inputs(36);
variable_37 = Inputs(37);
variable_38 = Inputs(38);
variable_39 = Inputs(39);
variable_40 = Inputs(40);

scaled_variable_1 = (variable_1+0.0470624)/0.0413838;

scaled_variable_2 = (variable_2+0.0512247)/0.0410448;

scaled_variable_3 = (variable_3+0.050311)/0.0413375;

scaled_variable_4 = (variable_4+0.0464099)/0.0415653;

scaled_variable_5 = (variable_5+0.0397133)/0.0414146;

scaled_variable_6 = (variable_6+0.0330083)/0.0422003;

scaled_variable_7 = (variable_7+0.0271058)/0.0419973;

scaled_variable_8 = (variable_8+0.0211524)/0.0412348;

scaled_variable_9 = (variable_9+0.0152459)/0.0412131;

scaled_variable_10 = (variable_10-0.00548528)/0.0548024;

scaled_variable_11 = (variable_11-0.0459545)/0.0848602;

scaled_variable_12 = (variable_12-0.107574)/0.118033;

scaled_variable_13 = (variable_13-0.186853)/0.144785;

scaled_variable_14 = (variable_14-0.284904)/0.150668;

scaled_variable_15 = (variable_15-0.386519)/0.151557;

scaled_variable_16 = (variable_16-0.488699)/0.150859;

scaled_variable_17 = (variable_17-0.590884)/0.150324;

scaled_variable_18 = (variable_18-0.694349)/0.150682;

scaled_variable_19 = (variable_19-0.796061)/0.15005;

scaled_variable_20 = (variable_20-0.857555)/0.113628;

scaled_variable_21 = (variable_21-0.877249)/0.0881688;

scaled_variable_22 = (variable_22-0.854166)/0.110968;

scaled_variable_23 = (variable_23-0.791862)/0.148498;

scaled_variable_24 = (variable_24-0.689181)/0.149018;

scaled_variable_25 = (variable_25-0.587587)/0.149573;

scaled_variable_26 = (variable_26-0.485144)/0.148522;

scaled_variable_27 = (variable_27-0.382143)/0.148469;

scaled_variable_28 = (variable_28-0.279541)/0.14808;

scaled_variable_29 = (variable_29-0.182087)/0.142922;

scaled_variable_30 = (variable_30-0.103173)/0.118337;

scaled_variable_31 = (variable_31-0.0437666)/0.0850077;

scaled_variable_32 = (variable_32-0.0042386)/0.0547969;

scaled_variable_33 = (variable_33+0.0163182)/0.0419271;

scaled_variable_34 = (variable_34+0.022327)/0.0419497;

scaled_variable_35 = (variable_35+0.0283952)/0.0420037;

scaled_variable_36 = (variable_36+0.0341907)/0.0414634;

scaled_variable_37 = (variable_37+0.040808)/0.0416659;

scaled_variable_38 = (variable_38+0.0470211)/0.041514;

scaled_variable_39 = (variable_39+0.051203)/0.0409985;

scaled_variable_40 = (variable_40+0.0508847)/0.0414888;

y_1_1 = tanh (0.00508145+ (scaled_variable_1*-0.0119305)+ (scaled_variable_2*0.00216811)+ (scaled_variable_3*-0.00463493)+ (scaled_variable_4*-0.0165079)+ (scaled_variable_5*0.013609)+ (scaled_variable_6*0.00424052)+ (scaled_variable_7*-0.00150972)+ (scaled_variable_8*0.0124476)+ (scaled_variable_9*0.0181122)+ (scaled_variable_10*-0.016059)+ (scaled_variable_11*-0.0150813)+ (scaled_variable_12*-0.00460314)+ (scaled_variable_13*-0.0100314)+ (scaled_variable_14*-0.00652008)+ (scaled_variable_15*-0.0100363)+ (scaled_variable_16*-0.00825535)+ (scaled_variable_17*-0.013852)+ (scaled_variable_18*-0.0138223)+ (scaled_variable_19*-0.015525)+ (scaled_variable_20*0.0264475)+ (scaled_variable_21*0.00332977)+ (scaled_variable_22*-0.0136266)+ (scaled_variable_23*0.0121486)+ (scaled_variable_24*0.0174913)+ (scaled_variable_25*0.00181298)+ (scaled_variable_26*0.0117991)+ (scaled_variable_27*0.013744)+ (scaled_variable_28*0.00820212)+ (scaled_variable_29*0.00341064)+ (scaled_variable_30*-0.00495652)+ (scaled_variable_31*-0.00575262)+ (scaled_variable_32*0.0151929)+ (scaled_variable_33*-0.0117068)+ (scaled_variable_34*0.00391026)+ (scaled_variable_35*0.0108186)+ (scaled_variable_36*0.0142878)+ (scaled_variable_37*-0.00121095)+ (scaled_variable_38*0.00405001)+ (scaled_variable_39*0.003362)+ (scaled_variable_40*0.00935425));

y_1_2 = tanh (-0.0464378+ (scaled_variable_1*0.0113151)+ (scaled_variable_2*0.0969748)+ (scaled_variable_3*-0.0175438)+ (scaled_variable_4*-0.0833492)+ (scaled_variable_5*0.00290759)+ (scaled_variable_6*-0.0286131)+ (scaled_variable_7*-0.0233323)+ (scaled_variable_8*-0.0122846)+ (scaled_variable_9*-0.011211)+ (scaled_variable_10*0.0778446)+ (scaled_variable_11*0.0852264)+ (scaled_variable_12*0.103885)+ (scaled_variable_13*-0.0916737)+ (scaled_variable_14*-0.111625)+ (scaled_variable_15*-0.0584551)+ (scaled_variable_16*-0.0401997)+ (scaled_variable_17*-0.0157974)+ (scaled_variable_18*-0.0186863)+ (scaled_variable_19*-0.0682535)+ (scaled_variable_20*-0.109203)+ (scaled_variable_21*-0.258242)+ (scaled_variable_22*-0.362057)+ (scaled_variable_23*0.296009)+ (scaled_variable_24*0.187194)+ (scaled_variable_25*0.152472)+ (scaled_variable_26*0.134191)+ (scaled_variable_27*0.0588006)+ (scaled_variable_28*0.0936014)+ (scaled_variable_29*0.0776876)+ (scaled_variable_30*0.0901974)+ (scaled_variable_31*0.216772)+ (scaled_variable_32*0.185408)+ (scaled_variable_33*-0.219292)+ (scaled_variable_34*-0.0484478)+ (scaled_variable_35*-0.0248602)+ (scaled_variable_36*-0.000569262)+ (scaled_variable_37*-0.0222522)+ (scaled_variable_38*0.014838)+ (scaled_variable_39*0.0338495)+ (scaled_variable_40*0.0262799));

y_1_3 = tanh (0.282064+ (scaled_variable_1*0.0274213)+ (scaled_variable_2*-0.136837)+ (scaled_variable_3*0.0177558)+ (scaled_variable_4*0.076811)+ (scaled_variable_5*0.0209011)+ (scaled_variable_6*-0.00562281)+ (scaled_variable_7*0.0238831)+ (scaled_variable_8*0.00546162)+ (scaled_variable_9*-0.0351782)+ (scaled_variable_10*-0.0197981)+ (scaled_variable_11*-0.146645)+ (scaled_variable_12*0.11039)+ (scaled_variable_13*0.144833)+ (scaled_variable_14*0.0979865)+ (scaled_variable_15*0.0840476)+ (scaled_variable_16*0.0459266)+ (scaled_variable_17*0.010784)+ (scaled_variable_18*0.0287409)+ (scaled_variable_19*-0.0345587)+ (scaled_variable_20*0.191647)+ (scaled_variable_21*0.610022)+ (scaled_variable_22*-0.38914)+ (scaled_variable_23*-0.112591)+ (scaled_variable_24*-0.162302)+ (scaled_variable_25*-0.135538)+ (scaled_variable_26*-0.120133)+ (scaled_variable_27*-0.0959623)+ (scaled_variable_28*-0.0442157)+ (scaled_variable_29*-0.0472918)+ (scaled_variable_30*-0.199285)+ (scaled_variable_31*-0.256542)+ (scaled_variable_32*0.101438)+ (scaled_variable_33*0.0853353)+ (scaled_variable_34*0.0172777)+ (scaled_variable_35*0.0153261)+ (scaled_variable_36*0.0234842)+ (scaled_variable_37*-0.0153255)+ (scaled_variable_38*-0.0455483)+ (scaled_variable_39*-0.0106353)+ (scaled_variable_40*-0.000227705));

y_1_4 = tanh (0.622917+ (scaled_variable_1*-0.00729356)+ (scaled_variable_2*-0.013189)+ (scaled_variable_3*0.00537521)+ (scaled_variable_4*-0.0435643)+ (scaled_variable_5*0.000656414)+ (scaled_variable_6*0.0610405)+ (scaled_variable_7*-0.0211932)+ (scaled_variable_8*0.0230846)+ (scaled_variable_9*0.142167)+ (scaled_variable_10*-0.178363)+ (scaled_variable_11*-0.0909333)+ (scaled_variable_12*-0.0552061)+ (scaled_variable_13*0.0299289)+ (scaled_variable_14*-0.0159397)+ (scaled_variable_15*-0.0263901)+ (scaled_variable_16*-0.0275416)+ (scaled_variable_17*-0.100339)+ (scaled_variable_18*-0.25595)+ (scaled_variable_19*-0.508367)+ (scaled_variable_20*0.591974)+ (scaled_variable_21*0.011371)+ (scaled_variable_22*0.0254043)+ (scaled_variable_23*-0.0315028)+ (scaled_variable_24*0.00233818)+ (scaled_variable_25*-0.00288091)+ (scaled_variable_26*0.0970282)+ (scaled_variable_27*0.0968414)+ (scaled_variable_28*0.120229)+ (scaled_variable_29*0.114909)+ (scaled_variable_30*-0.193466)+ (scaled_variable_31*-0.0296653)+ (scaled_variable_32*0.00871199)+ (scaled_variable_33*-0.02418)+ (scaled_variable_34*0.0421372)+ (scaled_variable_35*-0.0381514)+ (scaled_variable_36*0.0702402)+ (scaled_variable_37*-0.0662417)+ (scaled_variable_38*0.000549787)+ (scaled_variable_39*0.0270808)+ (scaled_variable_40*-0.0371246));

y_1_5 = tanh (-0.0264085+ (scaled_variable_1*0.0382918)+ (scaled_variable_2*-0.0338307)+ (scaled_variable_3*0.00490107)+ (scaled_variable_4*0.0201062)+ (scaled_variable_5*-0.0243884)+ (scaled_variable_6*-0.0151928)+ (scaled_variable_7*-0.0131097)+ (scaled_variable_8*0.0235628)+ (scaled_variable_9*0.0229306)+ (scaled_variable_10*0.0650842)+ (scaled_variable_11*-0.0396064)+ (scaled_variable_12*-0.104622)+ (scaled_variable_13*-0.0579718)+ (scaled_variable_14*-0.0447424)+ (scaled_variable_15*-0.0431201)+ (scaled_variable_16*-0.041361)+ (scaled_variable_17*-0.0510621)+ (scaled_variable_18*-0.0585665)+ (scaled_variable_19*-0.119214)+ (scaled_variable_20*-0.111231)+ (scaled_variable_21*0.00261725)+ (scaled_variable_22*0.159409)+ (scaled_variable_23*0.131264)+ (scaled_variable_24*0.0569876)+ (scaled_variable_25*0.0507698)+ (scaled_variable_26*0.0425933)+ (scaled_variable_27*0.0353346)+ (scaled_variable_28*0.0248206)+ (scaled_variable_29*0.056108)+ (scaled_variable_30*0.0844016)+ (scaled_variable_31*0.0180194)+ (scaled_variable_32*-0.116373)+ (scaled_variable_33*-0.0206007)+ (scaled_variable_34*0.0460136)+ (scaled_variable_35*0.0119331)+ (scaled_variable_36*0.0213138)+ (scaled_variable_37*0.0139484)+ (scaled_variable_38*0.0179598)+ (scaled_variable_39*0.00255001)+ (scaled_variable_40*-0.0435036));

y_1_6 = tanh (0.258082+ (scaled_variable_1*0.0531492)+ (scaled_variable_2*-0.065153)+ (scaled_variable_3*-0.0294311)+ (scaled_variable_4*0.0153156)+ (scaled_variable_5*-0.014107)+ (scaled_variable_6*3.25801e-05)+ (scaled_variable_7*0.0464123)+ (scaled_variable_8*0.0344568)+ (scaled_variable_9*0.00583982)+ (scaled_variable_10*0.107324)+ (scaled_variable_11*-0.242037)+ (scaled_variable_12*-0.162394)+ (scaled_variable_13*-0.0879878)+ (scaled_variable_14*-0.0605087)+ (scaled_variable_15*-0.0516931)+ (scaled_variable_16*-0.128107)+ (scaled_variable_17*-0.152599)+ (scaled_variable_18*-0.148773)+ (scaled_variable_19*-0.193737)+ (scaled_variable_20*-0.489994)+ (scaled_variable_21*0.62006)+ (scaled_variable_22*0.153583)+ (scaled_variable_23*0.0366305)+ (scaled_variable_24*0.0670443)+ (scaled_variable_25*0.0688178)+ (scaled_variable_26*0.0750017)+ (scaled_variable_27*0.0608024)+ (scaled_variable_28*0.0818678)+ (scaled_variable_29*0.136809)+ (scaled_variable_30*0.101225)+ (scaled_variable_31*-0.163823)+ (scaled_variable_32*0.000536684)+ (scaled_variable_33*-0.0614516)+ (scaled_variable_34*0.021513)+ (scaled_variable_35*0.0161427)+ (scaled_variable_36*0.0365988)+ (scaled_variable_37*0.0104892)+ (scaled_variable_38*-0.00282809)+ (scaled_variable_39*0.0325158)+ (scaled_variable_40*-0.0570304));

y_1_7 = tanh (0.0510086+ (scaled_variable_1*0.0436523)+ (scaled_variable_2*0.0195509)+ (scaled_variable_3*0.0225872)+ (scaled_variable_4*0.0197072)+ (scaled_variable_5*-0.0419896)+ (scaled_variable_6*-0.0399401)+ (scaled_variable_7*-0.0210449)+ (scaled_variable_8*-0.040957)+ (scaled_variable_9*-0.0446121)+ (scaled_variable_10*0.0996159)+ (scaled_variable_11*0.125819)+ (scaled_variable_12*0.120077)+ (scaled_variable_13*0.0700728)+ (scaled_variable_14*0.0593183)+ (scaled_variable_15*0.0382787)+ (scaled_variable_16*0.0187437)+ (scaled_variable_17*0.0144359)+ (scaled_variable_18*0.0119738)+ (scaled_variable_19*-0.0316713)+ (scaled_variable_20*-0.00783216)+ (scaled_variable_21*-0.156824)+ (scaled_variable_22*-0.147727)+ (scaled_variable_23*-0.0762135)+ (scaled_variable_24*-0.0202616)+ (scaled_variable_25*-0.0194444)+ (scaled_variable_26*-0.0335066)+ (scaled_variable_27*-0.0159929)+ (scaled_variable_28*-0.00465532)+ (scaled_variable_29*0.01791)+ (scaled_variable_30*0.0108425)+ (scaled_variable_31*0.0816519)+ (scaled_variable_32*0.120755)+ (scaled_variable_33*-0.0246429)+ (scaled_variable_34*-0.036748)+ (scaled_variable_35*-0.0506356)+ (scaled_variable_36*-0.0335368)+ (scaled_variable_37*0.0169214)+ (scaled_variable_38*0.00820538)+ (scaled_variable_39*0.0363854)+ (scaled_variable_40*0.0434586));

y_1_8 = tanh (-0.0952164+ (scaled_variable_1*0.0110566)+ (scaled_variable_2*0.0206033)+ (scaled_variable_3*0.0205875)+ (scaled_variable_4*0.0250889)+ (scaled_variable_5*-0.00205319)+ (scaled_variable_6*-0.0511857)+ (scaled_variable_7*-0.0264347)+ (scaled_variable_8*-0.0284462)+ (scaled_variable_9*-0.12327)+ (scaled_variable_10*0.142544)+ (scaled_variable_11*0.15546)+ (scaled_variable_12*0.0941918)+ (scaled_variable_13*0.058922)+ (scaled_variable_14*0.0586706)+ (scaled_variable_15*0.0841635)+ (scaled_variable_16*0.0987841)+ (scaled_variable_17*0.14711)+ (scaled_variable_18*0.197072)+ (scaled_variable_19*0.301561)+ (scaled_variable_20*-0.290503)+ (scaled_variable_21*-0.217262)+ (scaled_variable_22*-0.0934737)+ (scaled_variable_23*-0.0261538)+ (scaled_variable_24*-0.0256761)+ (scaled_variable_25*-0.0422255)+ (scaled_variable_26*-0.0256543)+ (scaled_variable_27*-0.0762275)+ (scaled_variable_28*-0.13083)+ (scaled_variable_29*-0.109687)+ (scaled_variable_30*0.100401)+ (scaled_variable_31*0.0814887)+ (scaled_variable_32*0.0249002)+ (scaled_variable_33*0.00756253)+ (scaled_variable_34*-0.0158757)+ (scaled_variable_35*0.00243293)+ (scaled_variable_36*-0.0412787)+ (scaled_variable_37*0.0278243)+ (scaled_variable_38*-0.00636939)+ (scaled_variable_39*-0.0251708)+ (scaled_variable_40*0.0565415));

y_1_9 = tanh (-0.0645033+ (scaled_variable_1*-0.0392926)+ (scaled_variable_2*-0.0368566)+ (scaled_variable_3*-0.0473514)+ (scaled_variable_4*0.00443024)+ (scaled_variable_5*-0.0180722)+ (scaled_variable_6*-0.0081932)+ (scaled_variable_7*0.0255734)+ (scaled_variable_8*0.00585434)+ (scaled_variable_9*-0.0107285)+ (scaled_variable_10*0.0949856)+ (scaled_variable_11*0.041213)+ (scaled_variable_12*-0.00196015)+ (scaled_variable_13*0.0128653)+ (scaled_variable_14*0.00734112)+ (scaled_variable_15*0.0168587)+ (scaled_variable_16*0.00689041)+ (scaled_variable_17*0.0213141)+ (scaled_variable_18*0.0332692)+ (scaled_variable_19*0.0114467)+ (scaled_variable_20*-0.104547)+ (scaled_variable_21*-0.00453548)+ (scaled_variable_22*0.0718094)+ (scaled_variable_23*-0.00191847)+ (scaled_variable_24*-0.0235249)+ (scaled_variable_25*0.0117716)+ (scaled_variable_26*-0.00603818)+ (scaled_variable_27*-0.0238305)+ (scaled_variable_28*-0.00546401)+ (scaled_variable_29*0.0172303)+ (scaled_variable_30*0.036207)+ (scaled_variable_31*0.0256843)+ (scaled_variable_32*-0.0250878)+ (scaled_variable_33*0.0358788)+ (scaled_variable_34*0.016739)+ (scaled_variable_35*0.00944617)+ (scaled_variable_36*-0.00899314)+ (scaled_variable_37*0.0336653)+ (scaled_variable_38*0.00984091)+ (scaled_variable_39*0.0312501)+ (scaled_variable_40*0.000577987));

y_1_10 = tanh (0.00134834+ (scaled_variable_1*0.00494923)+ (scaled_variable_2*-0.000300014)+ (scaled_variable_3*0.00169133)+ (scaled_variable_4*0.00727642)+ (scaled_variable_5*-0.00590372)+ (scaled_variable_6*-0.00155228)+ (scaled_variable_7*0.000102484)+ (scaled_variable_8*-0.00529638)+ (scaled_variable_9*-0.00707622)+ (scaled_variable_10*0.00920631)+ (scaled_variable_11*0.00798091)+ (scaled_variable_12*0.00348608)+ (scaled_variable_13*0.00612933)+ (scaled_variable_14*0.00477077)+ (scaled_variable_15*0.0063855)+ (scaled_variable_16*0.00576973)+ (scaled_variable_17*0.00841457)+ (scaled_variable_18*0.00848126)+ (scaled_variable_19*0.00899968)+ (scaled_variable_20*-0.010165)+ (scaled_variable_21*-0.000628417)+ (scaled_variable_22*0.00481371)+ (scaled_variable_23*-0.00692379)+ (scaled_variable_24*-0.00925053)+ (scaled_variable_25*-0.00277348)+ (scaled_variable_26*-0.00722787)+ (scaled_variable_27*-0.00841038)+ (scaled_variable_28*-0.00624965)+ (scaled_variable_29*-0.00399298)+ (scaled_variable_30*-0.000304172)+ (scaled_variable_31*-5.15317e-05)+ (scaled_variable_32*-0.00873846)+ (scaled_variable_33*0.00401339)+ (scaled_variable_34*-0.00235063)+ (scaled_variable_35*-0.00467411)+ (scaled_variable_36*-0.00577282)+ (scaled_variable_37*0.000775291)+ (scaled_variable_38*-0.00153769)+ (scaled_variable_39*-0.00149739)+ (scaled_variable_40*-0.00265213));

y_1_11 = tanh (0.0050061+ (scaled_variable_1*-0.0118204)+ (scaled_variable_2*0.00206589)+ (scaled_variable_3*-0.00469602)+ (scaled_variable_4*-0.0164362)+ (scaled_variable_5*0.0135033)+ (scaled_variable_6*0.0041747)+ (scaled_variable_7*-0.00147845)+ (scaled_variable_8*0.01223)+ (scaled_variable_9*0.0177981)+ (scaled_variable_10*-0.0159954)+ (scaled_variable_11*-0.0148894)+ (scaled_variable_12*-0.00446113)+ (scaled_variable_13*-0.00980489)+ (scaled_variable_14*-0.00639283)+ (scaled_variable_15*-0.00990319)+ (scaled_variable_16*-0.0081843)+ (scaled_variable_17*-0.013759)+ (scaled_variable_18*-0.0136903)+ (scaled_variable_19*-0.0153731)+ (scaled_variable_20*0.0261603)+ (scaled_variable_21*0.00346326)+ (scaled_variable_22*-0.0134047)+ (scaled_variable_23*0.0119588)+ (scaled_variable_24*0.0172449)+ (scaled_variable_25*0.00180534)+ (scaled_variable_26*0.0116948)+ (scaled_variable_27*0.0136428)+ (scaled_variable_28*0.00818428)+ (scaled_variable_29*0.00344719)+ (scaled_variable_30*-0.00477502)+ (scaled_variable_31*-0.00566237)+ (scaled_variable_32*0.0150674)+ (scaled_variable_33*-0.0115799)+ (scaled_variable_34*0.00381813)+ (scaled_variable_35*0.0104603)+ (scaled_variable_36*0.013782)+ (scaled_variable_37*-0.00140451)+ (scaled_variable_38*0.00390591)+ (scaled_variable_39*0.00324953)+ (scaled_variable_40*0.00888066));

y_1_12 = tanh (-0.00537622+ (scaled_variable_1*0.0117109)+ (scaled_variable_2*-0.00272717)+ (scaled_variable_3*0.00446384)+ (scaled_variable_4*0.016545)+ (scaled_variable_5*-0.0138142)+ (scaled_variable_6*-0.0042348)+ (scaled_variable_7*0.00180505)+ (scaled_variable_8*-0.0125993)+ (scaled_variable_9*-0.01883)+ (scaled_variable_10*0.0158296)+ (scaled_variable_11*0.0150516)+ (scaled_variable_12*0.00454441)+ (scaled_variable_13*0.0101181)+ (scaled_variable_14*0.00654089)+ (scaled_variable_15*0.0100219)+ (scaled_variable_16*0.00813876)+ (scaled_variable_17*0.0138138)+ (scaled_variable_18*0.0136779)+ (scaled_variable_19*0.0153934)+ (scaled_variable_20*-0.0269253)+ (scaled_variable_21*-0.0035399)+ (scaled_variable_22*0.0138137)+ (scaled_variable_23*-0.012375)+ (scaled_variable_24*-0.0177856)+ (scaled_variable_25*-0.0017508)+ (scaled_variable_26*-0.0118061)+ (scaled_variable_27*-0.0136795)+ (scaled_variable_28*-0.00799951)+ (scaled_variable_29*-0.00317795)+ (scaled_variable_30*0.00529896)+ (scaled_variable_31*0.00611031)+ (scaled_variable_32*-0.0150227)+ (scaled_variable_33*0.0122564)+ (scaled_variable_34*-0.00360213)+ (scaled_variable_35*-0.0110328)+ (scaled_variable_36*-0.0148879)+ (scaled_variable_37*0.000963218)+ (scaled_variable_38*-0.0045456)+ (scaled_variable_39*-0.00348018)+ (scaled_variable_40*-0.00989487));

y_1_13 = tanh (-0.00400129+ (scaled_variable_1*0.0109675)+ (scaled_variable_2*-0.00212722)+ (scaled_variable_3*0.00434581)+ (scaled_variable_4*0.0157851)+ (scaled_variable_5*-0.012958)+ (scaled_variable_6*-0.00393504)+ (scaled_variable_7*0.00131363)+ (scaled_variable_8*-0.0116593)+ (scaled_variable_9*-0.0168334)+ (scaled_variable_10*0.015626)+ (scaled_variable_11*0.0146277)+ (scaled_variable_12*0.00476028)+ (scaled_variable_13*0.0098712)+ (scaled_variable_14*0.00658944)+ (scaled_variable_15*0.00992178)+ (scaled_variable_16*0.00827835)+ (scaled_variable_17*0.0136427)+ (scaled_variable_18*0.0136032)+ (scaled_variable_19*0.0153038)+ (scaled_variable_20*-0.0246386)+ (scaled_variable_21*-0.00310038)+ (scaled_variable_22*0.012482)+ (scaled_variable_23*-0.0119345)+ (scaled_variable_24*-0.0170035)+ (scaled_variable_25*-0.0021144)+ (scaled_variable_26*-0.0116245)+ (scaled_variable_27*-0.0135102)+ (scaled_variable_28*-0.00825607)+ (scaled_variable_29*-0.00378226)+ (scaled_variable_30*0.00419804)+ (scaled_variable_31*0.00502346)+ (scaled_variable_32*-0.0145656)+ (scaled_variable_33*0.0112163)+ (scaled_variable_34*-0.00373922)+ (scaled_variable_35*-0.0102095)+ (scaled_variable_36*-0.0133981)+ (scaled_variable_37*0.00134962)+ (scaled_variable_38*-0.00378512)+ (scaled_variable_39*-0.00316222)+ (scaled_variable_40*-0.00841244));

y_1_14 = tanh (-0.0124836+ (scaled_variable_1*0.0181596)+ (scaled_variable_2*-0.00189263)+ (scaled_variable_3*0.00689285)+ (scaled_variable_4*0.0207363)+ (scaled_variable_5*-0.0171686)+ (scaled_variable_6*-0.00479783)+ (scaled_variable_7*0.00309405)+ (scaled_variable_8*-0.0174565)+ (scaled_variable_9*-0.0266437)+ (scaled_variable_10*0.0177839)+ (scaled_variable_11*0.016853)+ (scaled_variable_12*0.00348358)+ (scaled_variable_13*0.0108822)+ (scaled_variable_14*0.00643724)+ (scaled_variable_15*0.0106521)+ (scaled_variable_16*0.00792951)+ (scaled_variable_17*0.0150875)+ (scaled_variable_18*0.0149671)+ (scaled_variable_19*0.016522)+ (scaled_variable_20*-0.0367718)+ (scaled_variable_21*-0.00460583)+ (scaled_variable_22*0.0194569)+ (scaled_variable_23*-0.0141772)+ (scaled_variable_24*-0.0213764)+ (scaled_variable_25*-0.000794393)+ (scaled_variable_26*-0.0133097)+ (scaled_variable_27*-0.0156584)+ (scaled_variable_28*-0.00806028)+ (scaled_variable_29*-0.0014787)+ (scaled_variable_30*0.00908142)+ (scaled_variable_31*0.00929959)+ (scaled_variable_32*-0.0184251)+ (scaled_variable_33*0.0145687)+ (scaled_variable_34*-0.00415756)+ (scaled_variable_35*-0.0146084)+ (scaled_variable_36*-0.0197038)+ (scaled_variable_37*0.000790064)+ (scaled_variable_38*-0.0052903)+ (scaled_variable_39*-0.00397607)+ (scaled_variable_40*-0.0140722));

y_1_15 = tanh (0.0292786+ (scaled_variable_1*0.0342425)+ (scaled_variable_2*0.0181977)+ (scaled_variable_3*0.0483911)+ (scaled_variable_4*0.0358162)+ (scaled_variable_5*-0.031707)+ (scaled_variable_6*0.0145761)+ (scaled_variable_7*-0.00613538)+ (scaled_variable_8*0.00676643)+ (scaled_variable_9*-0.00823526)+ (scaled_variable_10*0.00310773)+ (scaled_variable_11*0.00453651)+ (scaled_variable_12*-0.011129)+ (scaled_variable_13*0.00720848)+ (scaled_variable_14*0.00630909)+ (scaled_variable_15*-0.00781014)+ (scaled_variable_16*-0.0148501)+ (scaled_variable_17*0.00536012)+ (scaled_variable_18*0.00965312)+ (scaled_variable_19*0.0210902)+ (scaled_variable_20*-0.0395373)+ (scaled_variable_21*-0.0425892)+ (scaled_variable_22*-0.0281485)+ (scaled_variable_23*-0.0616211)+ (scaled_variable_24*-0.0563076)+ (scaled_variable_25*-0.0154386)+ (scaled_variable_26*-0.0241782)+ (scaled_variable_27*-0.0315811)+ (scaled_variable_28*-0.0260266)+ (scaled_variable_29*-0.028284)+ (scaled_variable_30*-0.0162486)+ (scaled_variable_31*-0.00459216)+ (scaled_variable_32*-0.00522093)+ (scaled_variable_33*0.0266441)+ (scaled_variable_34*-0.0176158)+ (scaled_variable_35*0.0336398)+ (scaled_variable_36*0.0222633)+ (scaled_variable_37*0.021747)+ (scaled_variable_38*0.0675889)+ (scaled_variable_39*0.00512749)+ (scaled_variable_40*0.0506341));

y_1_16 = tanh (0.00607161+ (scaled_variable_1*-0.0127106)+ (scaled_variable_2*0.00220625)+ (scaled_variable_3*-0.00491406)+ (scaled_variable_4*-0.0170977)+ (scaled_variable_5*0.0141179)+ (scaled_variable_6*0.00438536)+ (scaled_variable_7*-0.00172384)+ (scaled_variable_8*0.0130246)+ (scaled_variable_9*0.019085)+ (scaled_variable_10*-0.016367)+ (scaled_variable_11*-0.0153367)+ (scaled_variable_12*-0.00446446)+ (scaled_variable_13*-0.0101345)+ (scaled_variable_14*-0.00651192)+ (scaled_variable_15*-0.0101701)+ (scaled_variable_16*-0.0083081)+ (scaled_variable_17*-0.0141217)+ (scaled_variable_18*-0.0140022)+ (scaled_variable_19*-0.015698)+ (scaled_variable_20*0.0276742)+ (scaled_variable_21*0.00364769)+ (scaled_variable_22*-0.0143298)+ (scaled_variable_23*0.0123589)+ (scaled_variable_24*0.0179325)+ (scaled_variable_25*0.00169158)+ (scaled_variable_26*0.0120155)+ (scaled_variable_27*0.0139907)+ (scaled_variable_28*0.00822075)+ (scaled_variable_29*0.00322375)+ (scaled_variable_30*-0.00535435)+ (scaled_variable_31*-0.00626862)+ (scaled_variable_32*0.0156472)+ (scaled_variable_33*-0.0120939)+ (scaled_variable_34*0.00397563)+ (scaled_variable_35*0.0111923)+ (scaled_variable_36*0.0147684)+ (scaled_variable_37*-0.00117949)+ (scaled_variable_38*0.00424975)+ (scaled_variable_39*0.00342579)+ (scaled_variable_40*0.00974752));

y_1_17 = tanh (0.00577832+ (scaled_variable_1*-0.0124107)+ (scaled_variable_2*0.0022061)+ (scaled_variable_3*-0.00486081)+ (scaled_variable_4*-0.0169584)+ (scaled_variable_5*0.0139701)+ (scaled_variable_6*0.00436052)+ (scaled_variable_7*-0.00160436)+ (scaled_variable_8*0.0128626)+ (scaled_variable_9*0.0187229)+ (scaled_variable_10*-0.0162664)+ (scaled_variable_11*-0.0152958)+ (scaled_variable_12*-0.00451441)+ (scaled_variable_13*-0.0101019)+ (scaled_variable_14*-0.00651926)+ (scaled_variable_15*-0.01015)+ (scaled_variable_16*-0.00832976)+ (scaled_variable_17*-0.0140585)+ (scaled_variable_18*-0.0139637)+ (scaled_variable_19*-0.0157025)+ (scaled_variable_20*0.0272226)+ (scaled_variable_21*0.00358913)+ (scaled_variable_22*-0.0140667)+ (scaled_variable_23*0.0122963)+ (scaled_variable_24*0.0177914)+ (scaled_variable_25*0.00175221)+ (scaled_variable_26*0.011966)+ (scaled_variable_27*0.0139359)+ (scaled_variable_28*0.00825032)+ (scaled_variable_29*0.00333398)+ (scaled_variable_30*-0.00515926)+ (scaled_variable_31*-0.00607164)+ (scaled_variable_32*0.0155407)+ (scaled_variable_33*-0.0119651)+ (scaled_variable_34*0.0040094)+ (scaled_variable_35*0.0110647)+ (scaled_variable_36*0.0145875)+ (scaled_variable_37*-0.00120719)+ (scaled_variable_38*0.0041492)+ (scaled_variable_39*0.00337509)+ (scaled_variable_40*0.00953659));

y_1_18 = tanh (-0.00506778+ (scaled_variable_1*0.0118883)+ (scaled_variable_2*-0.00206927)+ (scaled_variable_3*0.004749)+ (scaled_variable_4*0.0165695)+ (scaled_variable_5*-0.0136177)+ (scaled_variable_6*-0.00421575)+ (scaled_variable_7*0.00141792)+ (scaled_variable_8*-0.0124096)+ (scaled_variable_9*-0.0179385)+ (scaled_variable_10*0.0160573)+ (scaled_variable_11*0.015022)+ (scaled_variable_12*0.00450423)+ (scaled_variable_13*0.00990293)+ (scaled_variable_14*0.00645115)+ (scaled_variable_15*0.00999281)+ (scaled_variable_16*0.00825296)+ (scaled_variable_17*0.0138603)+ (scaled_variable_18*0.0138263)+ (scaled_variable_19*0.0155507)+ (scaled_variable_20*-0.0263288)+ (scaled_variable_21*-0.00341476)+ (scaled_variable_22*0.0135483)+ (scaled_variable_23*-0.0120624)+ (scaled_variable_24*-0.017397)+ (scaled_variable_25*-0.00183111)+ (scaled_variable_26*-0.0117977)+ (scaled_variable_27*-0.0137726)+ (scaled_variable_28*-0.00827383)+ (scaled_variable_29*-0.00349673)+ (scaled_variable_30*0.0048046)+ (scaled_variable_31*0.00566648)+ (scaled_variable_32*-0.0152798)+ (scaled_variable_33*0.0115882)+ (scaled_variable_34*-0.00399577)+ (scaled_variable_35*-0.010646)+ (scaled_variable_36*-0.014015)+ (scaled_variable_37*0.00131119)+ (scaled_variable_38*-0.00391442)+ (scaled_variable_39*-0.00332183)+ (scaled_variable_40*-0.00904906));

y_1_19 = tanh (-0.00629187+ (scaled_variable_1*0.0127202)+ (scaled_variable_2*-0.00224391)+ (scaled_variable_3*0.00502677)+ (scaled_variable_4*0.0171994)+ (scaled_variable_5*-0.0142004)+ (scaled_variable_6*-0.00440883)+ (scaled_variable_7*0.00172646)+ (scaled_variable_8*-0.013128)+ (scaled_variable_9*-0.0193725)+ (scaled_variable_10*0.016345)+ (scaled_variable_11*0.0153985)+ (scaled_variable_12*0.00443032)+ (scaled_variable_13*0.0100887)+ (scaled_variable_14*0.00647213)+ (scaled_variable_15*0.010146)+ (scaled_variable_16*0.00826817)+ (scaled_variable_17*0.014108)+ (scaled_variable_18*0.0139903)+ (scaled_variable_19*0.0157078)+ (scaled_variable_20*-0.0279313)+ (scaled_variable_21*-0.00384229)+ (scaled_variable_22*0.0143427)+ (scaled_variable_23*-0.0123979)+ (scaled_variable_24*-0.018013)+ (scaled_variable_25*-0.0016969)+ (scaled_variable_26*-0.012045)+ (scaled_variable_27*-0.0140405)+ (scaled_variable_28*-0.00822197)+ (scaled_variable_29*-0.00319975)+ (scaled_variable_30*0.00542631)+ (scaled_variable_31*0.00631519)+ (scaled_variable_32*-0.0157329)+ (scaled_variable_33*0.0120642)+ (scaled_variable_34*-0.00401014)+ (scaled_variable_35*-0.0112574)+ (scaled_variable_36*-0.0149282)+ (scaled_variable_37*0.00115337)+ (scaled_variable_38*-0.00428505)+ (scaled_variable_39*-0.0034385)+ (scaled_variable_40*-0.00978501));

y_1_20 = tanh (0.546662+ (scaled_variable_1*-0.0217968)+ (scaled_variable_2*-0.0435859)+ (scaled_variable_3*0.00138414)+ (scaled_variable_4*0.0739305)+ (scaled_variable_5*-0.0384567)+ (scaled_variable_6*0.053478)+ (scaled_variable_7*0.0212726)+ (scaled_variable_8*0.00313103)+ (scaled_variable_9*-0.0023024)+ (scaled_variable_10*-0.0556225)+ (scaled_variable_11*-0.00556029)+ (scaled_variable_12*-0.16897)+ (scaled_variable_13*0.0833429)+ (scaled_variable_14*0.0628648)+ (scaled_variable_15*0.0703547)+ (scaled_variable_16*0.035633)+ (scaled_variable_17*0.0228254)+ (scaled_variable_18*-0.0111301)+ (scaled_variable_19*0.0118991)+ (scaled_variable_20*0.0112816)+ (scaled_variable_21*0.0990916)+ (scaled_variable_22*0.559319)+ (scaled_variable_23*-0.421294)+ (scaled_variable_24*-0.16262)+ (scaled_variable_25*-0.100201)+ (scaled_variable_26*-0.0429156)+ (scaled_variable_27*-0.095937)+ (scaled_variable_28*-0.0382834)+ (scaled_variable_29*-0.0528207)+ (scaled_variable_30*-0.0380424)+ (scaled_variable_31*-0.107441)+ (scaled_variable_32*-0.234895)+ (scaled_variable_33*0.200111)+ (scaled_variable_34*0.0498321)+ (scaled_variable_35*0.00237966)+ (scaled_variable_36*-0.00851929)+ (scaled_variable_37*0.0170376)+ (scaled_variable_38*0.0247389)+ (scaled_variable_39*-0.0304197)+ (scaled_variable_40*-0.0279608));

scaled_variable_41 =  (0.0148947+ (y_1_1*-0.0827999)+ (y_1_2*-0.426705)+ (y_1_3*-0.575813)+ (y_1_4*0.612548)+ (y_1_5*-0.265163)+ (y_1_6*0.547665)+ (y_1_7*-0.234393)+ (y_1_8*0.456285)+ (y_1_9*0.181392)+ (y_1_10*0.034798)+ (y_1_11*-0.0810276)+ (y_1_12*0.0829399)+ (y_1_13*0.0785684)+ (y_1_14*0.106229)+ (y_1_15*0.152848)+ (y_1_16*-0.0853979)+ (y_1_17*-0.0846255)+ (y_1_18*0.0820358)+ (y_1_19*0.0857834)+ (y_1_20*-0.614678));
variable_41 = (0.5*(scaled_variable_41+1.0)*(2+2)-2);

variable_41 = max(-2, variable_41);

variable_41 = min(2, variable_41);
end