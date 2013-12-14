#include <MeggyJrSimple.h>

void setup()
{
  MeggyJrSimpleSetup();
  Serial.begin(9600);
}

int accidental= 0;

struct Point
{
  int x;
  int y;
};

Point Avatar = {1,1};

void loop()
{
  DrawPx (Avatar.x, Avatar.y, White);
  DisplaySlate();
  delay(100);
  DrawPx(Avatar.x, Avatar.y, Dark);
  
  CheckButtonsPress();
  if (Button_Left)
  {
    Avatar.x--;
    accidental = 0;
  }
  if (Button_Right)
  {
    Avatar.x++;
    accidental = 0;
  }
  if (Button_Up)
  {
    Avatar.y++;
    accidental = 0;
  }
  if (Button_Down)
  {
    Avatar.y--;
    accidental = 0;
  }
  if (Button_A)
  {
    indicator();
    sound();
    accidental++;
  }
  
  if (Avatar.x > 7)
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
  if (accidental == 2)
  {
    accidental = 0;
  }
}

void indicator()
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

void sound()
{
  if (Avatar.x == 1)
  {
    accidental = 0,
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
  }
  if (Avatar.x == 3)
  {
    Tone_Start(108970 / ((Avatar.y + 1 ) * 2), 1000 );
    delay(100);
    Serial.println(ToneD3);
  }
  if (Avatar.x == 4)
  {
    accidental = 0;
    Tone_Start(97082 / ((Avatar.y + 1 ) * 2), 1000);
    delay(100);
    Serial.println(ToneE3);
  }
  if (Avatar.x == 5)
  {
    Tone_Start(91632 / ((Avatar.y + 1 ) * 2), 1000);
    delay(100);
    Serial.println(ToneF3);
  }
  if (Avatar.x == 6)
  {
    Tone_Start(81632/ ((Avatar.y + 1 ) * 2), 1000);
    delay(100);
    Serial.println(ToneG3);
  }
  if (Avatar.x == 7)
  {
    Tone_Start(72726/ ((Avatar.y + 1 ) * 2), 1000);
    delay(100);
    Serial.println(ToneA3);
  }
}
