/*

  __  __ _      _                _       
 |  \/  (_)    | |              | |      
 | \  / |_  ___| |__   __ _  ___| |      
 | |\/| | |/ __| '_ \ / _` |/ _ | |      
 | |  | | | (__| | | | (_| |  __| |      
 |_|  |_|_|\___|_| |_|\__,_|\___|_|      
      | |          | |                   
      | | __ _  ___| | _____  ___  _ __  
  _   | |/ _` |/ __| |/ / __|/ _ \| '_ \ 
 | |__| | (_| | (__|   <\__ | (_) | | | |
  _____/ \__,_|\_____|\_|___/\___/|_| |_|
 |  _ \   /\   |  __ \                   
 | |_) | /  \  | |  | |                  
 |  _ < / /\ \ | |  | |                  
 | |_) / ____ \| |__| |                  
 |____/_/    \_|_____/   by Austin Sierra
			for Church of TempleOS

Last Edit:4/20/2024

*/


$SP,"<1>",BI=1$	//HEE HEE
	//SHAMONEH!
	//AOOOOOOW




Cd(__DIR__);;
#include "FileBMP.HC";
#define DC_NUM	4 //dither frames

CDC *cafe_dc[DC_NUM];//device context
CDC *crowd;
CDC *jz;
CDC* bg = DCNew(640,480);
CDC *mjDanceScene;

DCFill(bg,TRANSPARENT); 
bg->color = DKGRAY;
bg->thick=4;
GrLine3(bg,0,478,0,640,0,0);
GrLine3(bg,640,478,0,640,0,0);
GrLine3(bg,640,478,0,0,440,0);
GrFloodFill(bg,586,157,TRUE);

F64 glbl_scale;//mj scale
U8* dir; //DirCur
U8* file; //animation frame path
U8 framecounter=50; //time to next frame
U8 flip = 1; //image frame
U8 img = 0; //animation
I16 x = 400;//mj x pos
I16 y = 0;//mj y pos
I16 moonwalkOffset = 0;//moonwalk x offset transpose per/frame
I8 direction = 3; //moonwalk velocity
I32 moonwalkXCorrection=6400;//correction for reflection axis
Bool changeAnim = FALSE;//trigger to move to next anim
I16 crowdYOffset = 0;
I8 crowdDirection = 10;
I16 crowdXOffset = -160;
I16 jzYOffset = 0;//jesus rising
Bool enableDanceMode = FALSE;//show the dance scene
Bool preIntroDone = FALSE;
I16 preIntroXOffset = 100;

U0 PreIntro()
{
   SndRst;$UL,0$
   Play("5wCr");
     
}

U0 Intro()
{
   //Intro
   music.stacatto_factor= 3;
   music.tempo=5;
   Play("0eG1AA#Brr");

   //Background beat
   music.stacatto_factor = .5;
   Play("1hA2eA1wtC2eC1wtD2eD");
   music.stacatto_factor=1;
   Play("2qD#");//2eD#");
   music.stacatto_factor=.5;
   Play("1eE");
   music.stacatto_factor=1; 
   Play("2qErr");

   //next stanza
   Play("1qA");
   music.stacatto_factor=.5;
   Play("2eA1wtC2eC1wtD2eD");
   music.stacatto_factor=1;
   Play("2qD#");//2eD#");
   music.stacatto_factor=1;
   Play("e1E2hE");

   //Background beat
   music.stacatto_factor = .5;
   Play("1hA2eA1wtC2eC1wtD2eD");
   music.stacatto_factor=1;
   Play("2qD#");//2eD#");
   music.stacatto_factor=.5;
   Play("1eE");
   music.stacatto_factor=1; 
   Play("2qErr");

   //harmony comes in
   music.stacatto_factor = .5;
   Play("1qA2eA");
   Play("2wtC3eG2wtD3eF#");
   music.stacatto_factor=1;
   Play("2qD#");//2eD#");
   music.stacatto_factor=.5;
   Play("3eF");
   music.stacatto_factor=1; 
   Play("2qE3E");

   //harmony comes in
   music.stacatto_factor = .5;
   Play("1hA");
   Play("2wtC3eG2wtD3eF#");
   music.stacatto_factor=1;
   Play("2qD#");//2eD#");
   music.stacatto_factor=.5;
   Play("3eF");
   music.stacatto_factor=1; 
   Play("2qE3Err");
   
  //harmony comes in
   music.stacatto_factor = .5;
   Play("1qA");
   Play("2wtC3eG2wtD3eF#");
   music.stacatto_factor=1;
   Play("2qD#");//2eD#");
   music.stacatto_factor=.5;
   Play("3eF");
   music.stacatto_factor=1; 
   Play("2qE3Er");


   //harmony comes in
   music.stacatto_factor = .5;
   Play("1hA");
   Play("2wtC3eG2wtD3eF#");
   music.stacatto_factor=1;
   Play("2qD#");//2eD#");
   music.stacatto_factor=.5;
   Play("3eF");
   music.stacatto_factor=1; 
   Play("2qE3eE");



}


U0 Verse1()
{
   music.tempo=5;
   
   //lyrics begin
   music.stacatto_factor = .5;
   Play("3qA1eA3qCeAr4hC","\nYour \0butt \0is \0mine");
   music.stacatto_factor=.25;
   Play("2qChDqD#eEr");
   music.stacatto_factor = .5;
   Play("3eGGAr1A3qA4hC",", gon' \0tell \0you \0right.");
   music.stacatto_factor=.5;
   Play("2qChDqD#eE");
   music.stacatto_factor = .5;
   Play("3qA1eA3qCeAr4hC","\nJust \0show \0your \0face\0");
   music.stacatto_factor=.25;
   Play("2qChDqD#eEr");
   music.stacatto_factor = .5;
   Play("3eGAr1A3hAG"," in \0broad \0day\0light.");
   music.stacatto_factor=.5;
   Play("2qChDqD#eE");
   music.stacatto_factor = .5;
   Play("3eA1eA3qCeAr4hC","\nI'm \0tell\0in' \0you");
   music.stacatto_factor=.25;
   Play("2qChDqD#eEr");
   music.stacatto_factor = .5;
   Play("3eGGAqA1eA3qA4hC"," on \0who \0I \0feel.");
   music.stacatto_factor=.5;
   Play("2qChDqD#hE");
   music.stacatto_factor = .5;
   Play("3eAqA1eA3eCrA4hC","\nGonna \0hurt \0your \0mind");
   music.stacatto_factor=.25;
   Play("2qChDqD#eEr");
   music.stacatto_factor = .5;
   Play("3eGrArqAqG"," don't \0shoot \0to \0kill.");
   music.stacatto_factor=.5;
   Play("1qA2hCD3eAG2D#E","\nCo\0me\0 o\0n, ");
   music.stacatto_factor=.25;
   Play("1qA3qGAerGAD2qC3eArG2h2qD#eEr","co\0me \0o\0n!");

   Play("3eGGqGeA","\n\0Lay \0it \0on me.");
   music.stacatto_factor=.5;
   Play("1qA2hCD3qA4eC2qDe#E","\n\0Al\0right!\n");
   music.stacatto_factor=.25;
   Play("1qA3qGAerGA2hC2DqD#eEr");
   music.stacatto_factor=.5;
   Play("3eF#A4Cr3F#A4Cr1qA3eEGA2hCDqD#eEr");
     
    
}

U0 Verse2()
{
   
   //lyrics begin
   music.stacatto_factor = .5;
   Play("3qA1eA3qCeAr4hC","\nI'm \0giv\0ing \0you");
   music.stacatto_factor=.25;
   Play("2qChDqD#eEr");
   music.stacatto_factor = .5;
   Play("3eGGAr1A3qA4hC",", on \0count \0to \0three;\0");
   music.stacatto_factor=.5;
   Play("2qChDqD#eE");
   music.stacatto_factor = .5;
   Play("3qA1eA3qCeAr4hC","\nTo \0show \0your \0stuff");
   music.stacatto_factor=.25;
   Play("2qChDqD#eEr");
   music.stacatto_factor = .5;
   Play("3eGAr1A3hAG"," or \0let \0it \0be.");
   music.stacatto_factor=.5;
   Play("2qChDqD#eE");
   music.stacatto_factor = .5;
   Play("3eA1eA3qCeAr4hC","\nI'm \0tell\0in' \0you");
   music.stacatto_factor=.25;
   Play("2qChDqD#eEr");
   music.stacatto_factor = .5;
   Play("3eGGAqA1eA3qA4hC"," just \0watch \0your \0mouth.");
   music.stacatto_factor=.5;
   Play("2qChDqD#hE");
   music.stacatto_factor = .5;
   Play("3eAqA1eA3eCrA4hC","\nI \0know \0your \0game");
   music.stacatto_factor=.25;
   Play("2qChDqD#eEr");
   music.stacatto_factor = .5;
   Play("3eGrArqAhG"," what \0you're \0ab\0out.");

}

U0 Bridge1()
{
  music.tempo=5;
  music.stacatto_factor = .5;
  Play("3eAqAB1B3eB2D3qBeA2qC#4hC#qC#1G#2EC#",
       "\n\nWell, \0they \0say \0the \0sky's \0the \0lim\0it- ");
  Play("3eAA2C#3qB1B3eB2D3qBA4qC#2hC#","\nAnd\0 to\0 you \0that's\0 re\0ally\0 true!");
  music.tempo=6;
  music.stacatto_factor = .75;
  Play("1qG#2E4eE2qC#4EeF#1hB4eED2qD4eD#2D4eE2hC#4qE1qG#2E","\nBut,\0 my \0so\0n,\0 you\0 ha\0ve\0 se\0en\0 no\0thin' ");
  Play("4eE2eC#4eE2Ett3G#B4DG..rEr2Ett3G#B4DG..rE1E2Ett3G#B4DG..rE","\n\0Just\0 wait..\0.\0 \0't\0i\0l\0 I \0g\0e\0t \0th\0roug\0h!");
}

U0 Chorus1()
{
  music.tempo=5;
  music.stacatto_factor=.75;
  Play("2qD#eD4qGeA2qC","\n\nBe\0cause \0");
  music.tempo=7;
  Play("1eA2A5wCett1C5EGA6C..4qA2eCDtt4G5CDB..4wGeD#eE4qA","I'm\0 God,\0 I'm \0God.\0");
  Play("5qtCtEG6C..1eG2C5ettCEG6C..r5ettCEG6C..5ettCEG6C..2qC4eG5DF#A2D4A","\nI'm\0 re\0ally,\0 re\0ally\0 God!");
  music.tempo=5;
  Play("2qD#eD4qGeA2qC","\n\nYou \0know \0");
  music.tempo=7;
  Play("1eA2A5wCett1C5EGA6C..4qA2eCDtt4G5CDB..4wGeD#eE4qA","I'm\0 God,\0 I'm \0God.\0");
  Play("5qtCtEG6C..1eG2C5ettCEG6C..r5ettCEG6C..5ettCEG6C..2qC4eG5DF#A2D4A","\nI'm\0 re\0ally,\0 re\0ally\0 God!");
  music.tempo=5;
  Play("2qD#eD4qGeA2qC","\n\nYou \0know \0");
  music.tempo=7;
  Play("1eA2A5wCett1C5EGA6C..4qA2eCDtt4G5CDB..4wGeD#eE4qA","I'm\0 God,\0 I'm \0God.\0");
  Play("5qtCtEG6C..1eG2C5ettCEG6C..r5ettCEG6C..r5ettCEG6C..2qC4eG5DF#A2D4Arrr","\nYou \0 kno\0w, \0You \0kno\0w!");
  music.tempo=8;
  Play("ett4A5DF#A..rett4A5DF#A..r1Aett5CEA6C..ret5CEA6C.r2eCt5CEA6C.rtt5CEA6C..rett4A5DF#A..re2Dtt4A5DF#..rett4A5DF#A..re2D#tt4A5DF#A..rett1E4A5DF#A..rett4A5DF#A..ett5CEA6C..ett5CEA6C..1eA2Cet5CEA6C.ett5CEA6C..ett2D4A5DF#A..rrr4qrEh..D",
       "\nA\0n\0d\0 t\0h\0e w\0h\0o\0l\0e\0 w\0o\0r\0ld\0 \nh\0a\0s\0 t\0o\0 a\0n\0sw\0e\0r r\0i\0g\0h\0t n\0o\0w\0,\nJ\0u\0s\0t\0 t\0o\0 t\0e\0l\0l\0 y\0o\0u\0 o\0n\0c\0e\0 a\0g\0a\0i\0n\0;\0\n\0W\0ho's\0 G\0od?");
}


U0 Chorus2()
{
  DocClear;
  music.stacatto_factor=.75;
  music.tempo=7;
  Play("4qGeA2qC1eA2A5wCett1C5EGA6C..4qA2eCDtt4G5CDB..4wGeD#eE4qA","I'm\0 God,\0 I'm \0God.\0");
  Play("5qtCtEG6C..1eG2C5ettCEG6C..r5ettCEG6C..5ettCEG6C..2qC4eG5DF#A2D4A","\nI'm\0 re\0ally,\0 re\0ally\0 God!");
  music.tempo=5;
  Play("2qD#eD4qGeA2qC","\n\nYou \0know \0");
  music.tempo=7;
  Play("1eA2A5wCett1C5EGA6C..4qA2eCDtt4G5CDB..4wGeD#eE4qA","I'm\0 God,\0 I'm \0God.\0");
  Play("5qtCtEG6C..1eG2C5ettCEG6C..r5ettCEG6C..5ettCEG6C..2qC4eG5DF#A2D4A","\nI'm\0 re\0ally,\0 re\0ally\0 God!");
  music.tempo=5;
  Play("2qD#eD4qGeA2qC","\n\nYou \0know \0");
  music.tempo=7;
  Play("1eA2A5wCett1C5EGA6C..4qA2eCDtt4G5CDB..4wGeD#eE4qA","I'm\0 God,\0 I'm \0God.\0");
  Play("5qtCtEG6C..1eG2C5ettCEG6C..r5ettCEG6C..r5ettCEG6C..2qC4eG5DF#A2D4Arrr","\nYou \0 kno\0w, \0You \0kno\0w!");
  music.tempo=8;
  Play("ett4A5DF#A..rett4A5DF#A..r1Aett5CEA6C..ret5CEA6C.r2eCt5CEA6C.rtt5CEA6C..rett4A5DF#A..re2Dtt4A5DF#..rett4A5DF#A..re2D#tt4A5DF#A..rett1E4A5DF#A..rett4A5DF#A..ett5CEA6C..ett5CEA6C..1eA2Cet5CEA6C.ett5CEA6C..ett2D4A5DF#A..rrr4qrEh..D",
       "\nA\0n\0d\0 t\0h\0e w\0h\0o\0l\0e\0 w\0o\0r\0ld\0 \nh\0a\0s\0 t\0o\0 a\0n\0sw\0e\0r r\0i\0g\0h\0t n\0o\0w\0,\nJ\0u\0s\0t\0 t\0o\0 t\0e\0l\0l\0 y\0o\0u\0 o\0n\0c\0e\0 a\0g\0a\0i\0n\0;\0\n\0W\0ho's\0 G\0od?");
}


U0 Bridge2()
{
   //Background beat
   music.stacatto_factor = .5;
   music.tempo=7;
   Play("1wA2wCwDhD#hEqrr");
   Play("1hA2wCwDhD#hE");
   Play("1wA2wCwDhD#hEqrr");
   Play("1hA2wCwDhD#hE");
   DocClear;

}

U0 Verse3()
{
  music.tempo=5;
  music.stacatto_factor = .5;
  Play("3eAt1A3EG4C.h3Aet2C3EG4hC2.qDD#E3AettEDAEDA..1Aett3AED4C..2qCDD#E","The \0word \0is \0out, \0you\0're \0do\0ing \0it \0wr\0ong.");
  Play("e4EtCGA.1A4D2Cqtt3EG4DC3A..2CDD#E3ttAEGA..EGAttCEG..2qCDD#E","\nGon'\0 lock \0 you\0 up\0 be\0fore \0too \0long.");
  Play("3eAt1A3EG4C.h3Aet2C3EG4hC2.qDD#E3AettEDAEDA..1Aett3AED4C..2qCDD#E","\nYou\0r ly\0in' \0e\0y\0e\0s\0,\0 gon'\0 tell\0 you\0 right.");
  Play("e4EtCGA.1A4D2Cqtt3EG4DC3A..2CDD#E3ttAEGA..EGAttCEG..2qCDD#E","\nSo lis\0ten up,\0 don't \0make \0a \0fight");
  Play("3eAt1A3EG4C.h3Aet2C3EG4hC2.qDD#E3AettEDAEDA..1Aett3AED4C..2qCDD#E","\nYour \0talk \0is \0cheap, \0you're \0 not\0 a \0man.");
  Play("3eAt1A3EG4C.h3Aet2C3EG4hC2.qDD#E3AettEDAEDA..1Aett3AED4C..2qCDD#E","\nYou're\0 throw\0in' \0stones \0to \0hide \0your \0hands.");

}

U0 Bridge3()
{
  DocClear;
  music.tempo=7;
  music.stacatto_factor = .5;
  Play("1wA2wCwDhD#hEqrr");
  Play("1hA2wCwDhD#hEq");
  Play("1wA2wCeD2AB3CDEFGAB4C2D#4DEFGAB2E5.CDEFGAwB");

}

U0 Solo()
{
  music.tempo=7;
  music.stacatto_factor = .5;
  Play("1eG2C5qABAA5eD#ED2D5#DC4G2D#E");
  Play("5eG#A6wC1eG5EA2qC5D#DC4A5C2eDD#5eEAF#B2E5EACA1A5DA2C5eD#qAeEAD#EA2D5EC4BA2D#E");
  Play("5eEqGeEGEG1A5D#GEGEGEG2C5D#GEGEGEG2D5D#EGEGE2D#E5D#EGEGE1A5D#EGEGE2C5D#EGEGE2D5D#EG2D#E5D#DC1A4A5CD2C5D#D2D5D#EqGeA2D#E5");
  Play("5eEqG6wCe1AC5A1D5EGq6CeC#5EG6hCe1D#E5EG6CD1A5EG6hCe2C5EG6CD5EG6hCe2D6D2D#E5EG6qCeD5EG6qCe1A5GA6CwEDC5A");
}


U0 InitImage(U8 *filename)
{
  I64 i;

  if(enableDanceMode)
  {
   //for (i=0;i<DC_NUM;i++)
    mjDanceScene=BMPRead(filename,TRUE);

  }
  else{
  for (i=0;i<DC_NUM;i++)
    cafe_dc[i]=BMPRead(filename,TRUE);
  }
}

U0 InitBg()
{
  U8* file2 =MStrPrint("%s%s",dir,"/bg/crowd.bmp");
  crowd=BMPRead(file2,TRUE);
  U8* file3 =MStrPrint("%s%s",dir,"/jz/jesus.bmp");
  jz=BMPRead(file3,TRUE);

}

U0 CleanUpImage(CDC *dc)
{
  I64 i;
  //SettingsPop;
  if(enableDanceMode)
   DCDel(mjDanceScene);
  else
  {
 
  for (i=0;i<DC_NUM;i++)
    DCDel(cafe_dc[i]);
  }
}


U0 NextAnim()
{
  flip=1;
  img++;
  if(img==3)
   img=0;
  changeAnim=FALSE;
  moonwalkOffset = 0;//moonwalk x offset transpose per/frame
  direction = 3; //moonwalk velocity
  moonwalkXCorrection=6400;//correction for reflection axis
  jzYOffset=0;
}



U0 ResetAnim(CDC *dc)
{
  //I16 scale = .5;
  //scale = 1;
  if(enableDanceMode){
   framecounter=1;
  }
  else{
  switch(img)
  {
   case 0:
    x=400;
    y=0;
    glbl_scale=1;
    framecounter=10;
   break;
   case 1:
    glbl_scale=1.9;
    y=-30;
    framecounter=5;
    if(moonwalkOffset>=30)
    { 
      direction=-3;

      moonwalkXCorrection=0;

    }

    if(moonwalkOffset<=-30)
    {
      direction=3;

      moonwalkXCorrection=6400;

    }
    moonwalkOffset+=direction;
    x=225+moonwalkXCorrection;

   break;
   case 2:
    x=620;
    y=-60;
    glbl_scale=.6;
    framecounter=5;
   break;
  }


  if(jzYOffset<300)
   jzYOffset=jzYOffset+7;
  }

  crowdYOffset+=crowdDirection;
  if(crowdXOffset!=0)
   crowdXOffset++;

  if(crowdYOffset>=30)
  { 
    crowdDirection=-10;
  }

  if(crowdYOffset<=-30)
  {
    crowdDirection=10;

  }

}

U0 ConfigureAnimParam()
{

}

U0 DrawIt(CTask *,CDC *dc)
{
  DCFill;
  
  if(!preIntroDone)
  {
   preIntroXOffset--;
   if(preIntroXOffset==0)
    preIntroDone=TRUE;
  }

  
  if(img==2)
  {
     GrBlot3(dc,150,300-jzYOffset,0,jz);     
  }

  GrBlot(dc,0,0,bg);
  
  if(framecounter<=0)
  {
   if(changeAnim)
   {
    NextAnim;
   }

   ResetAnim(dc);

   if(enableDanceMode)
   {  
    if(flip==249)
        flip=0;
    else
        flip++;
    file =MStrPrint("%s%s%d%s",dir,"/mj/mj-",flip,".bmp");
   }
   else{
   switch(img)
   {
    case 0:
     if(flip)
      file =MStrPrint("%s%s%s",dir,"/crotch/1",".bmp");
     else
      file =MStrPrint("%s%s%s",dir,"/crotch/2",".bmp");
     flip = !flip;
    break;
    case 1:
     if(flip==8)
       flip=1;
     else
       flip++;
      file =MStrPrint("%s%s%d%s",dir,"/moonwalk/",flip,".bmp");
    break;
    case 2:
     if(flip==48)
      flip=1;
     else
      flip++;
      file =MStrPrint("%s%s%d%s",dir,"/dance/",flip,".bmp");

    break;
   }
   }

  }
  else
  {
   framecounter--;
  }


  if(!enableDanceMode)
  {

  CleanUpImage(dc);
  InitImage(file);

  dc->flags|=DCF_TRANSFORMATION;
  Mat4x4Scale(dc->r,.4);
  GrBlot3(dc,0+crowdXOffset,600+crowdYOffset,0,crowd);     
  
  //dc->flags|=DCF_TRANSFORMATION;
  Mat4x4IdentEqu(dc->r);
  if(img==1)
  {

   if(direction>0)
   { 
    DCSymmetrySet(dc,x,y,x,y-1);
    dc->flags|=DCF_TRANSFORMATION|DCF_SYMMETRY|DCF_JUST_MIRROR;
    Mat4x4Scale(dc->r,glbl_scale);
    GrBlot3(dc,x-moonwalkOffset,y,0,cafe_dc[winmgr.updates%DC_NUM]);
   }
   else
   {
    dc->flags|=DCF_TRANSFORMATION;
    dc->flags&=~(DCF_SYMMETRY|DCF_JUST_MIRROR);
    Mat4x4Scale(dc->r,glbl_scale);
    GrBlot3(dc,x+moonwalkOffset,y,0,cafe_dc[winmgr.updates%DC_NUM]);  
   }
  }
  else
  {
    dc->flags|=DCF_TRANSFORMATION;
    dc->flags&=~(DCF_SYMMETRY|DCF_JUST_MIRROR);
    Mat4x4Scale(dc->r,glbl_scale);
    GrBlot3(dc,x+preIntroXOffset,y,0,cafe_dc[winmgr.updates%DC_NUM]);  

  }
  //dc->flags&=~(DCF_SYMMETRY|DCF_JUST_MIRROR);
  }
  else
  {

   CleanUpImage(dc);
   InitImage(file);
   dc->flags|=DCF_TRANSFORMATION;
   dc->flags&=~(DCF_SYMMETRY|DCF_JUST_MIRROR);
   Mat4x4Scale(dc->r,1.2);
   GrBlot3(dc,0,-50,0,mjDanceScene);  

   Mat4x4IdentEqu(dc->r);
   dc->flags|=DCF_TRANSFORMATION;
   Mat4x4Scale(dc->r,.4);
   GrBlot3(dc,0+crowdXOffset,600+crowdYOffset,0,crowd);     

  
  }


}



U0 Main()
{
  
  SettingsPush;
  WinMax;
  WinBorder;
  DocCursor;
  DocClear;
  MenuPush("");
  dir = DirCur;
  file =MStrPrint("%s%s%s",dir,"/crotch/1",".bmp");
  ResetAnim(gr.dc);
  InitImage(file);
  InitBg();
  Fs->draw_it=&DrawIt;
  PreIntro;
  Intro;
  changeAnim=TRUE; 
  Verse1;
  Verse2;
  Bridge1;
  changeAnim=TRUE; 
  Chorus1;
  changeAnim=TRUE; 
  Bridge2;
  changeAnim=TRUE; 
  Verse3;
  Bridge1;
  changeAnim=TRUE; 
  Chorus1;
  changeAnim=TRUE;
  Bridge3;
  enableDanceMode=TRUE; 
  Solo;
  enableDanceMode=FALSE;
  changeAnim=TRUE; 
  Bridge1;
  changeAnim=TRUE; 
  Chorus1;
  Chorus2;
  changeAnim=TRUE; 
  //Outro
  //No Outro cause im tired of this project 
  MusicSettingsRst;
 
 DocClear;

}

Main;
        ‡	                                                                                                                                                                          	                                                                                                                                                            	                                                      	                                                	      	      
                                                                                                
                                                      	            	      
      	            
      
                                                 	      	      	      	      	      	      
      
      
      
      
      
      
      
      
      
      
                                                                                                                                                                                                                                             
                                                                                                                                                                                                                                                                                                                                                                                                                   	                                                                                                                                                                                                       