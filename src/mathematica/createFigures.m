(* ::Package:: *)

(************************************************************************)
(* This file was generated automatically by the Mathematica front end.  *)
(* It contains Initialization cells from a Notebook file, which         *)
(* typically will have the same name as this file except ending in      *)
(* ".nb" instead of ".m".                                               *)
(*                                                                      *)
(* This file is intended to be loaded into the Mathematica kernel using *)
(* the package loading commands Get or Needs.  Doing so is equivalent   *)
(* to using the Evaluate Initialization Cells menu command in the front *)
(* end.                                                                 *)
(*                                                                      *)
(* DO NOT EDIT THIS FILE.  This entire file is regenerated              *)
(* automatically each time the parent Notebook file is saved in the     *)
(* Mathematica front end.  Any changes you make to this file will be    *)
(* overwritten.                                                         *)
(************************************************************************)



currentPath = "src/mathematica/";


$HistoryLength=0;
figPath=currentPath<>"../../figures/";
inCm[l_]:=Floor[(l 72)/2.54]


ps=Directive[AbsoluteThickness[1],#]&/@{waterColor=RGBColor[0,0,.5],goldColor=RGBColor[218/256,165/256,32/256]};inputColor=RGBColor[.6,.85,.6];inputColor2=RGBColor[0.0,0.5,0.0];
drawRect[c1_,c2_]:={inputColor,Rectangle[c1,c2]}


t=2000;n=20;dt=1/10;dx=10;
defaultStyle={};
plotPost[dat_,startInput_:1800,xaxis_:True,i_:1,trainingCycle_:All,options_List:defaultStyle]:=Show[Graphics[drawRect[{startInput/dx/dt,0},{t/dx/dt,60}]],ListLinePlot[1000 Partition[dat[[All,i]],t/dt][[trainingCycle,1;;-1;;dx]],Sequence@@options,PlotStyle->(Directive[GrayLevel[1-#/10],If[#==10,AbsoluteThickness[1],AbsoluteThickness[.5]]]&/@Range[10])], Sequence@@options,PlotRange->All,ImageSize->inCm[4],LabelStyle->8,Axes->{xaxis,True},AxesStyle->AbsoluteThickness[1],Ticks->{{0,{t/dt/dx/2,t/2},{t/dt/dx,t}},{0,30,60}},AspectRatio->.4,ImagePadding->{{22,10},{All,All}}]
plotPre[dat_,showRate_:False]:=Show[If[showRate,ArrayPlot[Transpose[dat[[1;;-1;;10,20;;1;;-1]]],ColorFunction->(Blend[{White,Lighter[Blue,.7]},#]&),DataRange->{{1,t/dt},{1,20}}],Graphics[Rectangle[{0,0},{0,0}]]],Graphics[{AbsoluteThickness[.25],Blue,Line[{#+{0,-.5},#+{0,.5}}]}&/@Position[dat[[All,21;;-1]],1.]],Frame->{{True,False},{False,False}},PlotRangePadding->0, AspectRatio->.4, ImageSize->inCm[4],ImagePadding->{{22,10},{All,All}},FrameStyle->AbsoluteThickness[1],LabelStyle->8,FrameTicks->{None,{1,20}},PlotRange->{{0,t/dt},{0,21}},LabelStyle->8]


getTheory[gEatUS_]:=Module[{gE, Us, phiUs, \[Alpha],gamma},
gE=Table[If[t>1800/dt,gEatUS,0],{t,2000/dt}];
Us=gE 14/3/(1800+100+gE);
phiUs = 60 Us;
\[Alpha] = 1-Exp[-dt/10+dt/600.];
gamma = Table[Exp[-dt t/600.],{t,0,4000/dt}];
ListConvolve[Reverse[gamma],phiUs,1]/(10/dt)
]


post=Partition[Import[currentPath<>"../../data/rampUpPost.dat",{"Binary","Real64"}],5];
pre=Partition[Import[currentPath<>"../../data/rampUpPre.dat",{"Binary","Real64"}],2];
postC=Partition[Import[currentPath<>"../../data/rampUpPostC.dat",{"Binary","Real64"}],5];
preC=Partition[Import[currentPath<>"../../data/rampUpPreC.dat",{"Binary","Real64"}],2];


figRampPre=ListPlot[RandomSample[Mod[Range[0,1t/dt-dt],t/dt][[1;;-1;;100]]],PlotStyle->Directive[AbsoluteThickness[1],Blue],PlotMarkers ->Graphics[{AbsoluteThickness[.5],Blue,Line[{{0,-.005},{0,.005}}]}],ImageSize->inCm[4],LabelStyle->8,AspectRatio->.45,ImagePadding->{{22,6},{All,All}},Axes->{False,True},AxesStyle->AbsoluteThickness[1],Ticks->{None,{{t/dt/2,t/2},{t/dt,t}}},AxesOrigin->{0,0}]


figPSPneqPSPT=ListLinePlot[(#/Max@#)&/@{pre[[1;;400,1]],pre[[1;;400,2]]},ImageSize->inCm[1.6],LabelStyle->8,PlotRange->All,AxesStyle->AbsoluteThickness[1],Ticks->{{0,{200,20},{400,40}},None},PlotStyle->{Directive[AbsoluteThickness[1.5],Blue,Dashed],Directive[AbsoluteThickness[1],RGBColor[1,0,0,.5]]}]


figPSPeqPSPT=ListLinePlot[{preC[[1;;400,1]],preC[[1;;400,2]]},ImageSize->inCm[1.6],LabelStyle->8,PlotRange->All,AxesStyle->AbsoluteThickness[1],Ticks->None,PlotStyle->{Directive[AbsoluteThickness[1.5],Blue,Dashed],Directive[AbsoluteThickness[1],RGBColor[1,0,0,.5]]}]


theory=getTheory[15];


figRampPostNoPrediction=plotPost[postC,1800,False, 1, All, {PlotRange->All}]


figRampPost=Show[plotPost[post],ListLinePlot[theory[[1;;-1;;1/dt]],PlotStyle->Directive[AbsoluteThickness[1],Red,Dashed]]]


Export[figPath<>#<>".eps",ToExpression[#]]&/@{"figRampPre","figPSPneqPSPT","figPSPeqPSPT","figRampPostNoPrediction","figRampPost"}


postFP=Partition[Import[currentPath<>"../../data/rampUpFPPost.dat",{"Binary","Real64"}],5];
preFP=Partition[Import[currentPath<>"../../data/rampUpFPPre.dat",{"Binary","Real64"}],2 20];
postFPS=Partition[Import[currentPath<>"../../data/rampUpFPSPost.dat",{"Binary","Real64"}],5];
preFPS=Partition[Import[currentPath<>"../../data/rampUpFPSPre.dat",{"Binary","Real64"}],2 20];
postR=Partition[Import[currentPath<>"../../data/rampUpRatePost.dat",{"Binary","Real64"}],5];
preR=Partition[Import[currentPath<>"../../data/rampUpRatePre.dat",{"Binary","Real64"}],2 20];
postROU=Partition[Import[currentPath<>"../../data/rampUpRateOUPost.dat",{"Binary","Real64"}],5];
preROU=Partition[Import[currentPath<>"../../data/rampUpRateOUPre.dat",{"Binary","Real64"}],2 20];


theory=getTheory[15];
theory2=getTheory[7.5];


figFPPre=plotPre[preFP,False]
figFP=Show[plotPost[postFP],ListLinePlot[theory[[1;;-1;;1/dt]],PlotStyle->Directive[AbsoluteThickness[1],Red,Dashed]]]


figOUPre=plotPre[preROU,True]
figOU=Show[plotPost[postROU],ListLinePlot[theory[[1;;-1;;1/dt]],PlotStyle->Directive[AbsoluteThickness[1],Red,Dashed]]]


figOUSPre=plotPre[preFPS,True]
figOUS=Show[plotPost[postFPS],ListLinePlot[theory2[[1;;-1;;1/dt]],PlotStyle->Directive[AbsoluteThickness[1],Red,Dashed]]]


figThreeStimPre=plotPre[preR,True]
figThreeStimPost=plotPost[postR,2t/3]


Export[figPath<>#<>".eps",ToExpression[#]]&/@{"figFPPre","figFP","figOUSPre","figOUS","figOUPre","figOU", "figThreeStimPre","figThreeStimPost"}


dt = 1/10;n = 50;nw =2000;t=6000/dt;
tmp=Partition[Import[currentPath<>"../../data/delayedPairedAssociate.dat", {"Binary","Real64"}],4*n+12];


figDPApre=ListLinePlot[(MovingAverage[#,200/dt]&/@Partition[tmp[[All,3n+#]],t]/dt 1000)[[All,1;;-1;;100]],PlotStyle->ps,PlotRange->All,ImageSize->inCm[4.5],DataRange->{0,4},Axes->{False,True},AxesStyle->AbsoluteThickness[1],ImagePadding->{{12,2},{10,2}},Ticks->{{1,2,3,4},{-10000,40}},LabelStyle->7,AspectRatio->.3]&@20


figDPASpikes=ArrayPlot[(Total/@Partition[#,10/dt])&/@Partition[tmp[[All,3n+20]],t][[2;;-1;;2]],AspectRatio->.2,ColorFunctionScaling->False,ColorFunction->(If[#>=1,goldColor,Transparent]&),ImagePadding->{{12,2},{0,0}},ImageSize->inCm[4.5],Frame->None]


plot0[i_,o_,opt___]:=ListLinePlot[Partition[tmp[[All,-12+4(i-1)+o]],t][[All,1;;-1;;100]]/dt 1000,opt,PlotStyle->ps,PlotRange->All,ImageSize->inCm[4.5],AxesStyle->AbsoluteThickness[1],Ticks->{{t/dt/100/#,#-2}&/@Range[6],{20,40,60}},LabelStyle->8,AspectRatio->.4,ImagePadding->{{12,2},{10,2}}]
plot1[i_,o_,opt___]:=ListLinePlot[(Partition[tmp[[All,-12+4(i-1)+o]],t])[[All,1;;-1;;100]] 1000,opt,PlotStyle->ps,PlotRange->{{0,t/100},All},ImageSize->inCm[4.5],AxesStyle->AbsoluteThickness[1],Ticks->{{# t/100/6,#-1}&/@Range[6],{15,30,45}},LabelStyle->7,AspectRatio->.4,ImagePadding->{{12,2},{12,2}}]
plotP[i_,opt___]:=plot1[i,2,opt]


{figDPAneuron1,figDPAneuron2}=plotP[#,Axes->{False,True}]&/@Range[2]


figDPAneuron3=plotP[3,AspectRatio->.42]


Export[figPath<>#<>".eps",ToExpression[#]]&/@{"figDPApre","figDPAneuron1","figDPAneuron2","figDPAneuron3", "figDPASpikes"}


t=2000; dt=1/10;n=20;
load[i_]:=
(post=Partition[Import[currentPath<>"../../data/rotationsPost"<>i<>".dat",{"Binary","Real64"}],5];
pre=Partition[Import[currentPath<>"../../data/rotationsPre"<>i<>".dat",{"Binary","Real64"}],2n];
)
load["_100"]


ListLinePlot[1000Partition[post[[All,1]],t/dt][[All,1;;-1;;10]],PlotRange->Automatic,ImageSize->inCm[12],LabelStyle->8,Axes->{True,True},AxesStyle->AbsoluteThickness[1],Ticks->{{0,{t/dt/10/2,t/2},{t/dt/10,t}},Automatic},AspectRatio->.4,ImagePadding->{{22,10},{All,All}},AxesOrigin->{0,0},PlotStyle->(Directive[GrayLevel[1-#/10],If[#==10,AbsoluteThickness[1],AbsoluteThickness[.5]]]&/@Range[10])]
figRotation=ListLinePlot[Standardize/@(5000 Partition[post[[All,#]],t/dt][[-1,1;;-1;;10]]&/@{1,4}),PlotRange->{{0,All},All},ImageSize->inCm[5],LabelStyle->8,Axes->{False,True},AxesStyle->AbsoluteThickness[1],Ticks->{{0,{t/dt/10/2,t/2},{t/dt/10,t}},None},AspectRatio->.4,ImagePadding->{{22,10},{All,All}},AxesOrigin->{0,-2.2},PlotStyle->{Directive[AbsoluteThickness[1],Black],Directive[AbsoluteThickness[1],inputColor2],Directive[Red]}]


figRotationPre=Graphics[{AbsoluteThickness[.25],Blue,Line[{#+{0,-.5},#+{0,.5}}]}&/@Position[pre[[All,21;;-1]],1.],Axes->{True,True},AspectRatio->.4, ImageSize->inCm[5],ImagePadding->{{22,10},{All,All}},AxesStyle->AbsoluteThickness[1],LabelStyle->8,Ticks->{{0,{t/dt/2,t/2},{t/dt,t}},{1,20,100}},PlotRange->{{0,t/dt},{0,21}}]


corr[k_]:=Module[{s=post[[-3t/dt+k;;-t/dt+k,1]],t=post[[-3t/dt;;-t/dt,4]]},(s-Mean[s]).(t-Mean[t])]
acorr[k_]:=acorr[k,post[[-3t/dt;;-1,4]]]
acorr[k_,dat_]:=Module[{s=dat[[1+k;;t/dt+k]],t=dat[[1;;t/dt]]},(s-Mean[s]).(t-Mean[t])]
getMaxCC[i_]:=(
load["_"<>ToString[i]];
Position[#,Max@#]&@(corr/@Reverse@Range[4/5t/dt,t/dt-1])
)


getAlpha[\[Tau]_,\[Tau]e_]:=1-\[Tau]/\[Tau]e
range=Range[20,200,10];


resMaxCC002=Flatten[getMaxCC/@range dt];


getAlpha[9,100.]


figRotationCorrPeak=ListPlot[Transpose[{getAlpha[9,#]&/@range,resMaxCC002}],PlotStyle->Black,ImageSize->inCm[4],Ticks->{{.5,.75,1},{20,40,60}},AxesOrigin->{.3,0},PlotRange->{{.3,1},{0,75}},LabelStyle->8,AxesStyle->AbsoluteThickness[1],AspectRatio->.5,ImagePadding->{{18,8},{All,All}}]


corrr[i_]:=(
load["_"<>ToString[i]];
corr/@Reverse@Range[t/dt 4/5,t/dt-1]
)
acorD=acorr/@Reverse@Range[t/dt 4/5,t/dt-1];
tPeak=First[Flatten@getMaxCC[100]];
cor=corrr/@{100};
tPeak dt//N
figRotationCorr=Show[ListLinePlot[{1,.7}(Standardize/@Append[cor,acorD]),PlotRange->{{0,200/dt},All},Ticks->{{#,# dt}&/@(1000Range[3]),None},AxesOrigin->{0,-1.6},AspectRatio->.5,PlotStyle->{Directive[AbsoluteThickness[1],Black],Directive[AbsoluteThickness[1],inputColor2]},LabelStyle->8,AxesStyle->AbsoluteThickness[1],ImageSize->inCm[4],ImagePadding->{{18,8},{All,All}}],Graphics[{Dashed,Line[{{tPeak,-1.6},{tPeak,1.6}}]}]]


figTauEff=Show[Sequence@@Table[Plot[\[Tau]/(1-\[Alpha]),{\[Alpha],0,1},PlotRange->{{.68,1},{0,800}},AxesOrigin->{.68,0},Ticks->{Range[10]/10.,Range[0,1000,200]},LabelStyle->8,ImageSize->inCm[4],AspectRatio->1,AxesStyle->AbsoluteThickness[1],PlotStyle->(Directive[AbsoluteThickness[1],#]&/@{Black,Blue,RGBColor[0,.5,0],Red})[[\[Tau]/3-2]]],{\[Tau],9,15,3}]]


Export[figPath<>#<>".eps",ToExpression[#]]&/@{"figRotation", "figRotationPre","figRotationCorrPeak","figRotationCorr","figTauEff"}


dt = 1/10;n = 200;t=40/dt;
dir=currentPath<>"../../data/";
tmp=Partition[Import[dir<>"recurrent.dat", {"Binary","Real64"}],2n];
wd = Import[dir<>"recurrentWD.dat", {"Binary","Real64"}];
ww = Import[dir<>"recurrentW.dat", {"Binary","Real64"}];


www=Partition[ww,n];
MatrixPlot[www,Frame->None,FrameStyle->AbsoluteThickness[1],ImageSize->inCm[2.5],FrameTicks->None]


figRec=Graphics[Join[Append[{drawRect[{#,Mod[#,4]}{1000,n/4},{#+1,Mod[#,4]+1}{1000,n/4}]&/@Range[0,7]},drawRect[{6 4000,0},{6 4000+1 4000/8,50}]],{AbsoluteThickness[.25],Black,Line[{#+{0,-.5},#+{0,.5}}]}&/@Position[tmp[[1;;-1,1;;n]],1.]],Axes->{True,True},AspectRatio->.3, ImageSize->inCm[8],ImagePadding->{{22,10},{All,All}},AxesStyle->AbsoluteThickness[1],LabelStyle->8,Ticks->{({#,# dt}&/@Range[0,Length@tmp,Length@tmp/4]),{1,100,200}},PlotRange->{{0,Length@tmp},{0,200}}]


Export[figPath<>#<>".eps",ToExpression[#]]&/@{"figRec"}
