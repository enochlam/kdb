/ Utility function related to date time

/ A function to return the day of week for a list of dates
/ Example: 
/   dt2day(2000.01.01;2013.03.08) returns `Sat`Fri
dt2day:{((til 7)!`Sat`Sun`Mon`Tue`Wed`Thu`Fri)@`int$x mod 7};
