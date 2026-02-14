f = 60;        
d = 1000;       
N = 1000;       
for n = 1:N
    t(n) = (n-1)/d;              
    x(n) = cos(2*pi*f*t(n));      
end
figure;
plot(t, x, 'LineWidth', 1.5);
xlabel('Time (seconds)');
ylabel('Amplitude');
title('60 Hz Cosine Wave (1000 Samples)');
grid on;
