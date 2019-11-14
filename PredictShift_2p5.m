function variable_11 = PredictShift_2p5(Inputs)

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

scaled_variable_1 = (variable_1+0.0336529)/0.0250872;
scaled_variable_2 = (variable_2+0.0245872)/0.0217108;
scaled_variable_3 = (variable_3-0.0143649)/0.0568902;
scaled_variable_4 = (variable_4-0.202)/0.135375;
scaled_variable_5 = (variable_5-0.590248)/0.176932;
scaled_variable_6 = (variable_6-0.924538)/0.16001;
scaled_variable_7 = (variable_7-0.590505)/0.177078;
scaled_variable_8 = (variable_8-0.202189)/0.136049;
scaled_variable_9 = (variable_9-0.0142492)/0.0569561;
scaled_variable_10 = (variable_10+0.0246912)/0.021866;
y_1_1 = tanh (0.0103027+ (scaled_variable_1*0.034145)+ (scaled_variable_2*0.0610118)+ (scaled_variable_3*-0.036235)+ (scaled_variable_4*-0.096343)+ (scaled_variable_5*-0.11895)+ (scaled_variable_6*0.0171221)+ (scaled_variable_7*0.137965)+ (scaled_variable_8*0.108012)+ (scaled_variable_9*0.0432789)+ (scaled_variable_10*0.0220822));
y_1_2 = tanh (-0.277061+ (scaled_variable_1*-0.0197795)+ (scaled_variable_2*-0.0189173)+ (scaled_variable_3*0.0513916)+ (scaled_variable_4*0.102931)+ (scaled_variable_5*0.122833)+ (scaled_variable_6*-0.15521)+ (scaled_variable_7*-0.114664)+ (scaled_variable_8*-0.0308528)+ (scaled_variable_9*0.0454386)+ (scaled_variable_10*-0.0193236));
y_1_3 = tanh (-0.34393+ (scaled_variable_1*0.00123173)+ (scaled_variable_2*0.00410929)+ (scaled_variable_3*0.0333932)+ (scaled_variable_4*-0.0256943)+ (scaled_variable_5*-0.122572)+ (scaled_variable_6*-0.155014)+ (scaled_variable_7*0.158431)+ (scaled_variable_8*0.127239)+ (scaled_variable_9*0.0262074)+ (scaled_variable_10*0.0162523));
y_1_4 = tanh (0.325237+ (scaled_variable_1*0.0133848)+ (scaled_variable_2*-0.032028)+ (scaled_variable_3*-0.0985864)+ (scaled_variable_4*-0.172562)+ (scaled_variable_5*-0.194299)+ (scaled_variable_6*0.180506)+ (scaled_variable_7*0.163639)+ (scaled_variable_8*0.0610796)+ (scaled_variable_9*-0.00680306)+ (scaled_variable_10*0.00310898));
y_1_5 = tanh (0.0689462+ (scaled_variable_1*0.0014953)+ (scaled_variable_2*0.0697997)+ (scaled_variable_3*0.0632471)+ (scaled_variable_4*0.0927943)+ (scaled_variable_5*0.114189)+ (scaled_variable_6*0.0517562)+ (scaled_variable_7*-0.0863052)+ (scaled_variable_8*-0.0993178)+ (scaled_variable_9*-0.0659923)+ (scaled_variable_10*0.0159323));
y_1_6 = tanh (0.329877+ (scaled_variable_1*-0.0105319)+ (scaled_variable_2*-0.0079829)+ (scaled_variable_3*-0.0487476)+ (scaled_variable_4*0.0409321)+ (scaled_variable_5*0.143477)+ (scaled_variable_6*0.172765)+ (scaled_variable_7*-0.140972)+ (scaled_variable_8*-0.127302)+ (scaled_variable_9*-0.0717496)+ (scaled_variable_10*0.0472764));
y_1_7 = tanh (0.259699+ (scaled_variable_1*-0.0425024)+ (scaled_variable_2*0.0351423)+ (scaled_variable_3*-0.0942927)+ (scaled_variable_4*-0.109853)+ (scaled_variable_5*-0.0344637)+ (scaled_variable_6*0.339436)+ (scaled_variable_7*-0.0281772)+ (scaled_variable_8*-0.107878)+ (scaled_variable_9*-0.114199)+ (scaled_variable_10*0.0150968));
y_1_8 = tanh (-0.0844164+ (scaled_variable_1*0.00183961)+ (scaled_variable_2*-0.0517248)+ (scaled_variable_3*-0.0301948)+ (scaled_variable_4*-0.0297692)+ (scaled_variable_5*-0.0376777)+ (scaled_variable_6*-0.0894228)+ (scaled_variable_7*0.0305809)+ (scaled_variable_8*0.0602627)+ (scaled_variable_9*0.0542816)+ (scaled_variable_10*-0.0250551));
y_1_9 = tanh (-0.355683+ (scaled_variable_1*0.0162187)+ (scaled_variable_2*-0.00916782)+ (scaled_variable_3*0.0923017)+ (scaled_variable_4*0.160392)+ (scaled_variable_5*0.159833)+ (scaled_variable_6*-0.180647)+ (scaled_variable_7*-0.131761)+ (scaled_variable_8*-0.0683242)+ (scaled_variable_9*0.00705421)+ (scaled_variable_10*0.00289191));
y_1_10 = tanh (0.371377+ (scaled_variable_1*-0.00587178)+ (scaled_variable_2*0.00547511)+ (scaled_variable_3*-0.0266422)+ (scaled_variable_4*0.0448954)+ (scaled_variable_5*0.144715)+ (scaled_variable_6*0.173567)+ (scaled_variable_7*-0.160896)+ (scaled_variable_8*-0.140279)+ (scaled_variable_9*-0.0341507)+ (scaled_variable_10*0.00118841));
y_2_1 = tanh (-0.515753+ (y_1_1*-0.17442)+ (y_1_2*0.442767)+ (y_1_3*0.0696405)+ (y_1_4*-0.513157)+ (y_1_5*0.0903226)+ (y_1_6*-0.0899238)+ (y_1_7*-0.379632)+ (y_1_8*0.0393267)+ (y_1_9*0.581704)+ (y_1_10*-0.103306));
y_2_2 = tanh (-0.133852+ (y_1_1*0.0909715)+ (y_1_2*0.00557959)+ (y_1_3*0.0468805)+ (y_1_4*0.00879384)+ (y_1_5*-0.0575361)+ (y_1_6*-0.0717132)+ (y_1_7*0.0366168)+ (y_1_8*0.0160666)+ (y_1_9*-0.027252)+ (y_1_10*-0.0330968));
y_2_3 = tanh (0.112987+ (y_1_1*-0.0365617)+ (y_1_2*7.13841e-05)+ (y_1_3*-0.000541131)+ (y_1_4*0.0164929)+ (y_1_5*0.00161918)+ (y_1_6*0.0431421)+ (y_1_7*-0.0450221)+ (y_1_8*0.0105385)+ (y_1_9*0.0181873)+ (y_1_10*0.00453016));
y_2_4 = tanh (0.0215439+ (y_1_1*0.0829699)+ (y_1_2*-0.0511604)+ (y_1_3*0.0346931)+ (y_1_4*0.0360999)+ (y_1_5*-0.0565902)+ (y_1_6*-0.0401599)+ (y_1_7*-0.014192)+ (y_1_8*0.0143465)+ (y_1_9*-0.0771263)+ (y_1_10*-0.0148117));
y_2_5 = tanh (-0.106444+ (y_1_1*-0.116992)+ (y_1_2*0.0917893)+ (y_1_3*-0.0991975)+ (y_1_4*-0.0977002)+ (y_1_5*0.101384)+ (y_1_6*0.146897)+ (y_1_7*0.095398)+ (y_1_8*-0.0253341)+ (y_1_9*0.124232)+ (y_1_10*0.0890511));
y_2_6 = tanh (-0.112415+ (y_1_1*-0.0740131)+ (y_1_2*0.0357311)+ (y_1_3*0.0379817)+ (y_1_4*-0.0927012)+ (y_1_5*0.0435112)+ (y_1_6*-0.062825)+ (y_1_7*-0.0468188)+ (y_1_8*-0.0308812)+ (y_1_9*0.166953)+ (y_1_10*-0.054236));
y_2_7 = tanh (0.0172275+ (y_1_1*0.0217104)+ (y_1_2*-0.0140042)+ (y_1_3*0.0215908)+ (y_1_4*0.0309656)+ (y_1_5*-0.0303642)+ (y_1_6*-0.00977788)+ (y_1_7*-0.0108599)+ (y_1_8*0.0100145)+ (y_1_9*-0.0271988)+ (y_1_10*-0.0198237));
y_2_8 = tanh (0.0317485+ (y_1_1*0.054853)+ (y_1_2*-0.0419356)+ (y_1_3*0.0417897)+ (y_1_4*0.0542852)+ (y_1_5*-0.0576472)+ (y_1_6*-0.0220825)+ (y_1_7*-0.0352424)+ (y_1_8*0.0260448)+ (y_1_9*-0.0643854)+ (y_1_10*-0.0316045));
y_2_9 = tanh (0.0410604+ (y_1_1*-0.00848072)+ (y_1_2*-0.00833515)+ (y_1_3*-0.00624634)+ (y_1_4*0.0119827)+ (y_1_5*0.00577651)+ (y_1_6*0.0134792)+ (y_1_7*-0.00941924)+ (y_1_8*0.0005248)+ (y_1_9*-0.0055533)+ (y_1_10*0.00448629));
y_2_10 = tanh (-0.472503+ (y_1_1*0.165291)+ (y_1_2*0.0288089)+ (y_1_3*0.50445)+ (y_1_4*-0.0988261)+ (y_1_5*-0.209268)+ (y_1_6*-0.466544)+ (y_1_7*-0.348859)+ (y_1_8*0.129309)+ (y_1_9*0.0731362)+ (y_1_10*-0.522845));
scaled_variable_11 =  (0.0106483+ (y_2_1*-0.793459)+ (y_2_2*-0.193532)+ (y_2_3*-0.00236684)+ (y_2_4*-0.172372)+ (y_2_5*0.194053)+ (y_2_6*0.171904)+ (y_2_7*-0.0934002)+ (y_2_8*-0.209814)+ (y_2_9*0.000357772)+ (y_2_10*0.765557));
variable_11 = (0.5*(scaled_variable_11+1.0)*(1+1)-1);

end