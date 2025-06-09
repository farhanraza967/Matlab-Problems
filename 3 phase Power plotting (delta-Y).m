clc;
clear;

% === Initialize given values ===
f = 50;                      % Frequency in Hz
t = 0:0.0001:0.01;           % Time range (0 to 10ms)
w = 2 * pi * f;              % Angular frequency
VL = 207.85;                 % Line-to-line voltage

ZL = 2 + 1j*4;               % Line impedance (Ohms)
ZYL = 30 + 1j*40;            % Y-connected load impedance
ZDelta = 60 - 1j*45;         % Delta-connected load impedance

% === Convert Delta load to equivalent Y-connected load ===
ZYL = ZDelta / 3;

% === Calculate voltages and currents ===
VP = VL / sqrt(3);          % Phase voltage
ZT = ZL + ZYL + ZYL;        % Total impedance in the path
IP = VP / ZT;               % Phase current

VD = IP * ZL;               % Voltage drop across line
VL = VP - VD;               % Voltage at load

% Currents in branches of Y-load
IY1 = VL / ZYL;
IY2 = VL / ZYL;

% Delta line current from one branch
IDeltaline = sqrt(3) * IY2;

% === Power Calculations ===
S = 3 * VP * conj(IP);        % Total apparent power
P = real(S);                  % Real power (W)
Q = imag(S);                  % Reactive power (VAR)

PY1 = 3 * abs(IY1)^2 * ZYL;   % Power in 1st Y branch
PY2 = 3 * abs(IY2)^2 * ZYL;   % Power in 2nd Y branch
PL  = 3 * abs(IP)^2 * ZL;     % Power in line
Ptotal = PY1 + PY2 + PL;      % Total power consumed

% === Generate waveforms for plotting ===
v_phase = abs(VP) * sin(w * t + angle(VP));
v_load  = abs(VL) * sin(w * t + angle(VL));
i_phase = abs(IP) * sin(w * t + angle(IP));
i_delta = abs(IDeltaline) * sin(w * t + angle(IY2));

% === Plot Phase Voltage (VP) ===
figure;
plot(t * 1000, v_phase, 'b');
title('Phase Voltage (VP)');
xlabel('Time (ms)');
ylabel('Voltage (V)');
grid on;

% === Plot Load Voltage (VL) ===
figure;
plot(t * 1000, v_load, 'g');
title('Load Voltage (VL)');
xlabel('Time (ms)');
ylabel('Voltage (V)');
grid on;

% === Plot Phase Current (IP) ===
figure;
plot(t * 1000, i_phase, 'r');
title('Phase Current (IP)');
xlabel('Time (ms)');
ylabel('Current (A)');
grid on;

% === Plot Delta Line Current ===
figure;
plot(t * 1000, i_delta, 'm');
title('Delta Line Current');
xlabel('Time (ms)');
ylabel('Current (A)');
grid on;
