//+------------------------------------------------------------------+
//|                                                    sFractals.mq4 |
//|                      Copyright © 2005, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2005, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net"
//----
#property indicator_chart_window
#property indicator_buffers 2
#property indicator_color1 Orange
#property indicator_color2 BlueViolet
#property indicator_width1 7
#property indicator_width2 7

extern bool    SendEmail=false;
//---- buffers
double ExtUpFractalsBuffer[];
double ExtDownFractalsBuffer[];
// Íîìåð áàðà, ïî êîòîðîìó áóäåò èñêàòüñÿ ñèãíàë
#define SIGNAL_BAR 2
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- indicator buffers mapping  
    SetIndexBuffer(0, ExtUpFractalsBuffer);
    SetIndexBuffer(1, ExtDownFractalsBuffer);   
//---- drawing settings
    SetIndexStyle(0, DRAW_ARROW);
    SetIndexArrow(0, 119);
    SetIndexStyle(1, DRAW_ARROW);
    SetIndexArrow(1, 119);
//----
    SetIndexEmptyValue(0, 0.0);
    SetIndexEmptyValue(1, 0.0);
//---- name for DataWindow
    SetIndexLabel(0, "sFractal Up");
    SetIndexLabel(1, "sFractal Down");
//---- initialization done   
   return(0);
  }
//+------------------------------------------------------------------+
//| Custor indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
   int    i, nCountedBars;
   bool   bFound;
   double dCurrent;
   nCountedBars = IndicatorCounted();
//---- last counted bar will be recounted    
   if(nCountedBars <= 2)
       i = Bars - nCountedBars - 3;
   if(nCountedBars > 2)
     {
       nCountedBars--;
       i = Bars - nCountedBars - 1;
     }
//----Up and Down Fractals
   while(i >= 2)
     {
       //----Fractals up
       bFound = false;
       dCurrent = High[i];
       if(dCurrent > High[i+1] && dCurrent > High[i+2] && dCurrent > High[i-1] && 
          dCurrent > High[i-2])
         {
           bFound = true;
           ExtUpFractalsBuffer[i] = dCurrent;
         }
       //----6 bars Fractal
       if(!bFound && (Bars - i - 1) >= 3)
         {
           if(dCurrent == High[i+1] && dCurrent > High[i+2] && dCurrent > High[i+3] &&
              dCurrent > High[i-1] && dCurrent > High[i-2])
             {
               bFound = true;
               ExtUpFractalsBuffer[i] = dCurrent;
             }
         }         
       //----7 bars Fractal
       if(!bFound && (Bars - i - 1) >= 4)
         {   
           if(dCurrent >= High[i+1] && dCurrent == High[i+2] && dCurrent > High[i+3] && 
              dCurrent > High[i+4] && dCurrent > High[i-1] && dCurrent > High[i-2])
             {
               bFound = true;
               ExtUpFractalsBuffer[i] = dCurrent;
             }
         }  
       //----8 bars Fractal                          
       if(!bFound && (Bars - i - 1) >= 5)
         {   
           if(dCurrent >= High[i+1] && dCurrent == High[i+2] && dCurrent == High[i+3] && 
              dCurrent > High[i+4] && dCurrent > High[i+5] && dCurrent > High[i-1] && 
              dCurrent > High[i-2])
             {
               bFound = true;
               ExtUpFractalsBuffer[i] = dCurrent;
             }
         } 
       //----9 bars Fractal                                        
       if(!bFound && (Bars - i - 1) >= 6)
         {   
           if(dCurrent >= High[i+1] && dCurrent == High[i+2] && dCurrent >= High[i+3] && 
              dCurrent == High[i+4] && dCurrent > High[i+5] && dCurrent > High[i+6] && 
              dCurrent > High[i-1] && dCurrent > High[i-2])
             {
               bFound = true;
               ExtUpFractalsBuffer[i] = dCurrent;
             }
         }                                    
       //----Fractals down
       bFound = false;
       dCurrent = Low[i];
       if(dCurrent < Low[i+1] && dCurrent < Low[i+2] && dCurrent < Low[i-1] && 
          dCurrent < Low[i-2])
         {
           bFound = true;
           ExtDownFractalsBuffer[i] = dCurrent;
         }
       //----6 bars Fractal
       if(!bFound && (Bars - i - 1) >= 3)
         {
           if(dCurrent == Low[i+1] && dCurrent < Low[i+2] && dCurrent < Low[i+3] &&
              dCurrent < Low[i-1] && dCurrent < Low[i-2])
             {
               bFound = true;
               ExtDownFractalsBuffer[i] = dCurrent;
             }                      
         }         
       //----7 bars Fractal
       if(!bFound && (Bars - i - 1) >= 4)
         {   
           if(dCurrent <= Low[i+1] && dCurrent == Low[i+2] && dCurrent < Low[i+3] && 
              dCurrent < Low[i+4] &&
              dCurrent < Low[i-1] && dCurrent < Low[i-2])
             {
               bFound = true;
               ExtDownFractalsBuffer[i] = dCurrent;
             }                      
         }  
       //----8 bars Fractal                          
       if(!bFound && (Bars - i - 1) >= 5)
         {   
           if(dCurrent <= Low[i+1] && dCurrent == Low[i+2] && dCurrent==Low[i+3] && 
              dCurrent < Low[i+4] && dCurrent < Low[i+5] && dCurrent < Low[i-1] && 
              dCurrent < Low[i-2])
             {
               bFound = true;
               ExtDownFractalsBuffer[i] = dCurrent;
             }                      
         } 
       //----9 bars Fractal                                        
       if(!bFound && (Bars - i- 1) >= 6)
         {   
           if(dCurrent <= Low[i+1] && dCurrent == Low[i+2] && dCurrent <= Low[i+3] && 
              dCurrent == Low[i+4] && dCurrent < Low[i+5] && dCurrent < Low[i+6] && 
              dCurrent < Low[i-1] && dCurrent < Low[i-2])
             {
               bFound = true;
               ExtDownFractalsBuffer[i] = dCurrent;
             }                      
         }                                    
       i--;
     }
// Ñòàòè÷åñêèå ïåðåìåííûå, â êîòîðûõ õðàíÿòñÿ âðåìÿ ïîñëåäíåãî áàðà è íàïðàâëåíèå 
// ïîñëåäíåãî ñèãíàëà
	  static int PrevSignal = 0, PrevTime = 0;
// Åñëè áàðîì äëÿ àíàëèçà âûáðàí íå 0-é, íàì íåò ñìûñëà ïðîâåðÿòü ñèãíàë íåñêîëüêî ðàç. 
// Åñëè íå íà÷àëñÿ íîâûé áàð, âûõîäèì.
	  if(SIGNAL_BAR > 0 && Time[0] <= PrevTime) 
	      return(0);
// Îòìå÷àåì, ÷òî ýòîò áàð ïðîâåðåí
	  PrevTime = Time[0];
// Åñëè ïðåäûäóùèé ñèãíàë áûë ÑÅËË èëè ýòî ïåðâûé çàïóñê (PrevSignal=0)
	  if(PrevSignal <= 0)
	    {
		     if(ExtDownFractalsBuffer[SIGNAL_BAR] > 0)
		       {
			        PrevSignal = 1;
			        //Alert("sFractals (", Symbol(), ", ", Period(), ")  -  BUY!!!");
			        //SendMail (Symbol()+" "+Period()+ ": ",Symbol()+" "+Period()+": Fractal BUY Alert @ "+DoubleToStr(Bid,Digits));
			        SendNotification (Symbol()+" "+TFToStr(Period())+": Fractal de COMPRA Alert @ "+DoubleToStr(Bid,Digits));
		       }
	    }
	  if(PrevSignal >= 0)
	    {
		     if(ExtUpFractalsBuffer[SIGNAL_BAR] > 0)
		       {
			        PrevSignal = -1;
			        //Alert("sFractals (", Symbol(), ", ", Period(), ")  -  SELL!!!");
			        //SendMail (Symbol()+" "+Period()+ ": ",Symbol()+" "+Period()+": Fractal SELL Alert @ "+DoubleToStr(Bid,Digits));
			        SendNotification(Symbol()+" "+TFToStr(Period())+": Fractal de VENTA Alert @ "+DoubleToStr(Bid,Digits));
		       }
	    }
//----
   return(0);
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
string TFToStr(int tf)   {
//+------------------------------------------------------------------+
  if (tf == 0)        tf = Period();
  if (tf >= 43200)    return("MN");
  if (tf >= 10080)    return("W1");
  if (tf >=  1440)    return("D1");
  if (tf >=   240)    return("H4");
  if (tf >=    60)    return("H1");
  if (tf >=    30)    return("M30");
  if (tf >=    15)    return("M15");
  if (tf >=     5)    return("M5");
  if (tf >=     1)    return("M1");
  return("");
}