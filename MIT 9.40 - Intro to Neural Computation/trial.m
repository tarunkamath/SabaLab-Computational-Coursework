x = -pi:pi/20:pi;
y1 = sin(x);
plot(x,y1)

hold on 
y2 = cos(x);
plot(x,y2,'--')
hold off

legend('sin(x)','cos(x)')