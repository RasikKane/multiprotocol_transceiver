#ifndef ADCKBDLCD_H
#define ADCKBDLCD_H

void ADC_init(void);
int ADC(void);
int keybord(void);
void LcdInit (void);
void DisplayRow (int row, char *str);

#endif /* ADCKBDLCD_H */
