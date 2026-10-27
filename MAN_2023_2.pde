import controlP5.*;
ControlP5 cp5;

import processing.serial.*;
Serial port;

import javax.swing.JOptionPane;

int lastReminderTime;
int reminderInterval = 30*60 * 1000; // 30 minutes in milliseconds
int countdownStart ;

import processing.sound.*;
SoundFile sound;


//File file = new File("cal_mem.txt");

boolean soundPlayed = false; 

Chart myChart0;
Chart myChart1;
Chart myChart2;
Chart myChart3;

boolean pogana = false;

//int n0 = 0;
//int n1 = 0;
//int n2 = 0;
//int n3 = 0;

float CenterX;
float CenterY;

float CenterX0 = 0;
float CenterY0 = 0;

int A0 = 0;
int A1 = 0;
int A2 = 0;
int A3 = 0; 

float size0=10;
float size1=10;
float size2=10;
float size3=10;

int colFrame=60;
boolean[] bufpogana = new boolean[colFrame];
int idGetData=0;
int persentTrue=50;

PFont VDSboldFont;
PFont VDSFont;

int lastSoundTime = 0;

int BUTTON_X = 715;
int BUTTON_Y = 80;
int BUTTON_WIDTH = 300;
int BUTTON_HEIGHT = 70;

boolean isButtonHovered = false; 

String set_text;


void setup() 
{

//     if (file.exists()) 
//     {
//         file.delete();
//         PrintWriter cal_mem = createWriter("cal_mem.txt");
//         cal_mem.println(A0 + "\t" + A1 + "\t" + A2 + "\t" + A3);
//         cal_mem.flush(); // Завершення запису
//         cal_mem.close(); // Закриття файлу
         
          
//     } 
//     else
//     {
//         PrintWriter cal_mem = createWriter("cal_mem.txt");
//         cal_mem.println(A0 + "\t" + A1 + "\t" + A2 + "\t" + A3);
//         cal_mem.flush(); // Завершення запису
//         cal_mem.close(); // Закриття файлу       
//     }
  print(Serial.list());
  port = new Serial(this, Serial.list()[2], 9600); 
  port.bufferUntil('\n');
  
  sound = new SoundFile(this, "sound.mp3");
  
  size(1142, 624);
  background(255);
  
  cp5 = new ControlP5(this);
  
  VDSboldFont = createFont("C:/Users/illia/Documents/MAH/Шрифти/VDS Thin/VDS_Thin.ttf", 45);
  VDSFont = createFont("C:/Users/illia/Documents/MAH/Шрифти/VDS_bold/VDS_Bold_New.ttf", 25);
  
  textFont(VDSboldFont); 
  
  String text_PO = "Posture position:"; 
  textSize(60);
  fill(0);
  text(text_PO, 30, 70);
  
  textFont(VDSFont);
  
  String text_1 = "Pressure on the 1-st sensor:"; 
  textSize(23);
  fill(0);
  text(text_1, 50, 180);
  
  String text_2 = "Pressure on the 2-nd sensor:"; 
  textSize(23);
  fill(0);
  text(text_2, 50, 290);
  
  String text_3 = "Pressure on the 3-rd sensor:"; 
  textSize(23);
  fill(0);
  text(text_3, 50, 400);
  
  String text_4 = "Pressure on the 4-th sensor:"; 
  textSize(23);
  fill(0);
  text(text_4, 50, 510);
  

  myChart0 = cp5.addChart("")
               .setPosition(50, 190)
               .setSize(500, 70)
               .setRange(0, 1023)
               .setView(Chart.LINE) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
               .setColorCaptionLabel(color(50))
               ;               
  myChart0.addDataSet("incoming");
  myChart0.setData("incoming", new float[100]);
  
  myChart1 = cp5.addChart(" ")
               .setPosition(50, 300)
               .setSize(500, 70)
               .setRange(0, 1023)
               .setView(Chart.LINE) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
               .setColorCaptionLabel(color(50))
               ;               
  myChart1.addDataSet("incoming");
  myChart1.setData("incoming", new float[100]);
  
  myChart2 = cp5.addChart("   ")
               .setPosition(50, 410)
               .setSize(500, 70)
               .setRange(0, 1023)
               .setView(Chart.LINE) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
               .setColorCaptionLabel(color(50))
               ;               
  myChart2.addDataSet("incoming");
  myChart2.setData("incoming", new float[100]);
  
  myChart3 = cp5.addChart("    ")
               .setPosition(50, 520)
               .setSize(500, 70)
               .setRange(0, 1023)
               .setView(Chart.LINE) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
               .setColorCaptionLabel(color(50))
               ;               
  myChart3.addDataSet("incoming");
  myChart3.setData("incoming", new float[100]);
  
  noFill(); 
  stroke(0); 
  strokeWeight(10); 
  rect(665, 190, 400, 400, 50); 
  
}

void serialEvent(Serial port)
{
  String input = port.readStringUntil('\n');
  
  if (input != null) {

    // The data is split into an array of Strings with a comma or asterisk as a delimiter and converted into an array of integers.
    int[] vals = int(split(input, " "));
    float[] valsf = float(split(input, " ")); 
    

    // Fill r,g,b variables
    A0 = vals[0];
    A1 = vals[1];
    A2 = vals[2];
    A3 = vals[3];
    CenterX = valsf[4];
    CenterY = valsf[5];
    print(str(A0) + " ");
    print(str(A1) + " ");
    print(str(A2) + " ");
    print(str(A3) + " ");
    print(str(CenterX) + " ");
    println(str(CenterY) + " ");
    //for(int i=0;i<colFrame;i++){
      
    //}
  }
}


void draw() 
{
  
  textFont(VDSFont);
  
  noStroke();
  fill(255);
  rect(400, 160, 50, 30);
  textSize(10);
  fill(0);
  text(str(A0), 400, 180);

  noStroke();
  fill(255);
  rect(400, 270, 50, 30);
  textSize(10);
  fill(0);
  text(str(A1), 400, 290);

  noStroke();
  fill(255);
  rect(400, 380, 50, 30);
  textSize(10);
  fill(0);
  text(str(A2), 400, 400);


  noStroke();
  fill(255);
  rect(400, 490, 50, 30);
  textSize(10);
  fill(0);
  text(str(A3), 400, 510);
  
  //A0
  fill(255); 
  stroke(70); 
  strokeWeight(7); 
  ellipse(750, 278, 60, 60);
  
  fill(#5C62F0); 
  noStroke();
  size0 = map(A0, 0, 1024, 10, 55);
  ellipse(750, 278, size0, size0);
  
  //A1
  fill(255);  
  stroke(70); 
  strokeWeight(7); 
  ellipse(980, 278, 60, 60); 

  fill(#5C62F0); 
  noStroke();
  size1 = map(A1, 0, 1024, 10, 55);
  ellipse(980, 278, size1, size1);
  
  //A2
  fill(255);  
  stroke(70); 
  strokeWeight(7); 
  ellipse(775, 502, 60, 60);

  fill(#5C62F0); 
  noStroke();
  size2 = map(A2, 0, 1024, 10, 50);
  ellipse(775, 502, size2, size2);
  
  //A3
  fill(255); 
  stroke(70); 
  strokeWeight(7); 
  ellipse(955, 502, 60, 60); 

  fill(#5C62F0); 
  noStroke();
  size3 = map(A3, 0, 1024, 10, 50);
  ellipse(955, 502, size3, size3);
  
  //Charts
  myChart0.push("incoming", A0);
  
  myChart1.push("incoming", A1);
  
  myChart2.push("incoming", A2);
  
  myChart3.push("incoming", A3);
  ////READER
  //BufferedReader reader = createReader("cal_mem.txt");
  //String line = null;
  //try 
  //{
  //  while ((line = reader.readLine()) != null) //перевіряє чи щитаний рядок не пустий або заповнений
  //  {
  //    String[] analogs = split(line, TAB);
  //    n0 = int(analogs[0]);
  //    n1 = int(analogs[1]);
  //    n2 = int(analogs[2]);
  //    n3 = int(analogs[3]);     
  //  }
  //  reader.close();
  //} 
  //catch (IOException e) 
  //{
  //e.printStackTrace();
  //}
  
  //BUTTON
  fill(225);
  noStroke();
  
  if (mouseX >= BUTTON_X && mouseX <= BUTTON_X + BUTTON_WIDTH && mouseY >= BUTTON_Y && mouseY <= BUTTON_Y + BUTTON_HEIGHT) 
  {
    isButtonHovered = true; 
    fill(#8296DB);
  } 
  else 
  {
    isButtonHovered = false; 
    fill(205); 
  }
  
  if(mousePressed && isButtonHovered)
  {
    //n0 = A0;
    //n1 = A1;
    //n2 = A2;
    //n3 = A3;
    CenterX0 = CenterX;
    CenterY0 = CenterY;
    println("Calibrated");
    for (int i =0;i<colFrame;i++){
      bufpogana[i]=false;

    }
  }
  
  rect(BUTTON_X, BUTTON_Y, BUTTON_WIDTH, BUTTON_HEIGHT, 10);
  

  textFont(VDSboldFont); 
  String text_kn = "CALIBRATE"; 
  textSize(45);
  fill(0);
  text(text_kn, 744, 130);
  
  fill(255);
  noStroke();
  rect(40, 80, 650, 80);
  
  
  if(CenterX0==0  &&  CenterY0==0)
  { 
   set_text = "Calibrate the seat";
   textSize(65);
   fill(#8084DB);
  }  
  else
  {
      

      if(A0>=0 && A0<=10  &&  A1>=0 && A1<=10   &&  A2>=0 && A2<=10  &&  A3>=0 && A3<=10)
      {
       
       set_text = "Sit on the seat";
       textSize(65);
       fill(120);
      }  
       else
      {
        if(CenterX>=CenterX0-10 && CenterX<=CenterX0+10 && CenterY>=CenterY0-10 && CenterY<=CenterY0+10)
        {
         bufpogana[idGetData]=false;
         idGetData++;
         idGetData%=colFrame;
     
        }
        else
        {
         bufpogana[idGetData]=true;
         idGetData++;
         idGetData%=colFrame;

          
        }
        int col=0;
        for (int i =0;i<colFrame;i++){
          if(bufpogana[i]){
            col++;
          }
        }
        if(col>colFrame/2){
          set_text = "Sit up straighter on the seat :|";
          textSize(50);
          fill(#ED84A0);
         
        }
        else {
          set_text = "Good posture :)";
          textSize(65);
          fill(#84ED94);
        }
      }
  }
      
  
  //if(n0==0  &&  n1==0   &&  n2==0 &&  n3==0 )
  //{ 
  // set_text = "Calibrate the seat";
  // textSize(65);
  // fill(#8084DB);
  //}  
  //else
  //{
  //    if(A0>=0 && A0<=10  &&  A1>=0 && A1<=10   &&  A2>=0 && A2<=10  &&  A3>=0 && A3<=10)
  //    {
       
  //     set_text = "Sit on the seat";
  //     textSize(65);
  //     fill(120);
  //    }
  //    else
  //    {
  //      if((A2>n2-70 && n2+70>A2)   &&   (A3>n3-70 && n3+70>A3)   &&   (A0>n0-70 && n0+70>A0)   &&   (A1>n1-70 && n1+70>A1))
  //      {
  //       pogana = false;
  //       set_text = "Good posture :)";
  //       textSize(65);
  //       fill(#84ED94);
          
  //      }
  //      else
  //      {
  //        pogana = true;
  //        set_text = "Sit up straighter on the seat :|";
  //        textSize(50);
  //        fill(#ED84A0);

  //      }
  //    }
 
  //}
  
  
  
  text(set_text, 40, 140);


  
  
  if (millis() - lastReminderTime > reminderInterval) {
    countdownStart = millis(); // Reset the countdown start time
    lastReminderTime = millis(); // Reset the timer

    String message = "Time for a 5-minute warm-up!\n\n";
    JOptionPane.showMessageDialog(null, message); // Show pop-up reminder with countdown
  }

}



//void mousePressed()
//{
//   if (isButtonHovered ) 
//   {
//      file.delete();
//      PrintWriter cal_mem = createWriter("cal_mem.txt");
//      cal_mem.println(A0 + "\t" + A1 + "\t" + A2 + "\t" + A3);
//      cal_mem.flush(); // Завершення запису
//      cal_mem.close(); // Закриття файлу
//      println("Калібровано");
//    } 
 
//}
