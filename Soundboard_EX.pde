#include <MeggyJrSimple.h>

void setup()
{
  MeggyJrSimpleSetup();
  Serial.begin(9600);
}

int accidental= 0;
int note = 0;
int score = 1;

struct Point
{
  int x;
  int y;
};

Point Avatar = {1,1};

Point memory[8] = {};
int sharp[8] = {};

void loop() //avatar coding and basic program rules
{
  DrawPx (Avatar.x, Avatar.y, White);
  DisplaySlate();
  delay(100);
  DrawPx(Avatar.x, Avatar.y, Dark);
  
  CheckButtonsPress(); //button coding
  if (Button_Left)
  {
    Avatar.x--;
    accidental = 0;
    ClearSlate();
  }
  if (Button_Right)
  {
    Avatar.x++;
    accidental = 0;
    ClearSlate();
  }
  if (Button_Up)
  {
    Avatar.y++;
    accidental = 0;
    ClearSlate();
  }
  if (Button_Down)
  {
    Avatar.y--;
    accidental = 0;
    ClearSlate();
  }
  if (Button_A)
  {
    indicator();
    sound();
  }
  if (Button_B) // runs save function
  {
    save();
    accidental = 0;
  }
  
  if (Avatar.x > 7) //boundaries of cursor
  {
    Avatar.x = 7;
    
  }
  if (Avatar.x < 1)
  {
    Avatar.x = 1;
  
  }
  if (Avatar.y < 0)
  {
    Avatar.y = 0;
 
  }
  if (Avatar.y > 7)
  {
    Avatar.y = 7;
 
  }
  if (accidental == 2) //resets accidental
  {
    accidental = 0;
  }
  
  if (score > 128) // resets aux leds
  {
    play();
    score = 1;
  } 
}
  

void indicator() //flat and sharp detector
{
  if (accidental == 0)
  {
    DrawPx(0, Avatar.y, Green);
    DisplaySlate();
    delay(1000);
  }
  if (accidental == 1)
  {
    DrawPx(0, Avatar.y, Blue);
    DisplaySlate();
    delay(1000);
  }
}

void sound() //plays sounds depending on x and y position of avatar and the accidental tag for sharps
{
  if (Avatar.x == 1)
  {
    Tone_Start(129566 / ((Avatar.y + 1 ) * 2), 1000);
    delay(100);
    Serial.println(ToneB2);
  }
  if (Avatar.x == 2)
  {
    if (accidental == 1)
    {
      Tone_Start(115448/ ((Avatar.y + 1 ) * 2), 1000);
      delay(100);
      Serial.println(ToneCs3);
    }
    if (accidental == 0)
    {
      Tone_Start(122314 / ((Avatar.y + 1 ) * 2), 1000);
      delay(100);
      Serial.println(ToneC3);
    }
    accidental++;
  }
  if (Avatar.x == 3)
  {
    if (accidental == 0)
    {
      Tone_Start(108970 / ((Avatar.y + 1 ) * 2), 1000 );
      delay(100);
      Serial.println(ToneD3);
    }
    if (accidental == 1)
    {
      Tone_Start(102854 / ((Avatar.y + 1 ) * 2),1000);
      delay(100);
      Serial.println(ToneDs3);
    }
    accidental++;
  }
  if (Avatar.x == 4)
  {
    Tone_Start(97082 / ((Avatar.y + 1 ) * 2), 1000);
    delay(100);
    Serial.println(ToneE3);
  }
  if (Avatar.x == 5)
  {
    if (accidental == 0)
    {
      Tone_Start(91632 / ((Avatar.y + 1 ) * 2), 1000);
      delay(100);
      Serial.println(ToneF3);
    }
    if (accidental == 1)
    {
      Tone_Start(86486 / ((Avatar.y + 1 ) * 2), 1000);
      delay(100);
      Serial.println(ToneFs3);
    }
    accidental++;
  }
  if (Avatar.x == 6)
  {
    if (accidental == 0)
    {
      Tone_Start(81632/ ((Avatar.y + 1 ) * 2), 1000);
      delay(100);
      Serial.println(ToneG3);
    }
    if (accidental == 1)
    {
      Tone_Start(77052/ ((Avatar.y + 1 ) * 2), 1000);
      delay(100);
      Serial.println(ToneGs3);
    }
    accidental++;
  }
  if (Avatar.x == 7)
  {
    if (accidental == 0)
    {
      Tone_Start(72726/ ((Avatar.y + 1 ) * 2), 1000);
      delay(100);
      Serial.println(ToneA3);
    }
    if (accidental == 1)
    {
      Tone_Start(68646/ ((Avatar.y + 1 ) * 2), 1000);
      delay(100);
      Serial.println(ToneAs3);
    }
    accidental++;
  }
}

void save()
{
  memory[note] = Avatar; // save current location to array and change aux led
  accidental++;
  sharp[note] = accidental;
  ClearSlate();
  DisplaySlate();
  delay(1000);
  SetAuxLEDs(score);
  score = score*2;
  note++;
}

void play()
{
  for (note = 0; note < 7; note++)
  {
    Avatar = memory[note]; // set Avatar to saved position
    accidental = sharp[note];
    sound();
    delay(25);
  }
  ClearSlate();
  score = 0;
  SetAuxLEDs(score);
  note = 0;
  accidental = 0;
}
    
