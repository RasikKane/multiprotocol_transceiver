#ifndef DACKBDLCD_H
#define DACKBDLCD_H

int ADC(void);
int DAC(int);
int keybord(void);
void LcdInit (void);
void DisplayRow (int row, char *str);

#endif /* DACKBDLCD_H */
