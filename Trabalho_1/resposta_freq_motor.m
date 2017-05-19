
%Define as constantes dadas no trabalho
kt = 0.0502;
ke = kt;
jm = 221e-7;
la = 0.82e-3;
ra = 10.6;
num = kt;
den = [ra*jm ke*kt];

%Define a função de transferência
H = tf(num,den)

%Cria a figura da resposta ao degrau
figure;
step(H)
[y_step_model,t_step_model] = step(H,5);
fig_step=gcf;
grid on;

%Cria o diagrama de Bode
figure;
bode(H)
[mag,phase,wout] = bode(H);
fig_bode=gcf;
grid on;

%Bota o tamanho das fontes das figuras em FontSize
fontsize = 12;
set(findall(fig_step,'-property','FontSize'),'FontSize',fontsize)
set(findall(fig_bode,'-property','FontSize'),'FontSize',fontsize)

%Salva as figuras do grafico de Bode e a resposta ao degrau
saveas(fig_bode,'images/bode_response.png')
saveas(fig_step,'images/step_response.png')


f = [0.16 0.25 0.39 0.63 1 1.60 2.52 3.99 6.33 9.8];
f = f;
y = [11.5 10.2 8.75 7.69 5.9 3.58 2.57 1.976 1.28 0.85];
delta_t = [0.2 0.37 0.16 0.18 0.13 0.1 0.09 0.06 0.05 0.04];
delta_phi = delta_t.*f.*2*pi;
delta_phi = rad2deg(delta_phi);

%pequenas correções (pegado errado da tabela)
delta_phi(2) = 22.46;
delta_phi(3) = 33.30;
delta_phi(9) = 89.12;
delta_phi(10) = 89.95;

w = 2*pi*f;
mag = reshape(mag,1,56);
phase = reshape(phase,1,56);


fig_comp_phase = figure;
semilogx((w), -delta_phi);
hold on;
semilogx(wout,phase)
grid on;
legend('Medição','Modelo')
xlabel('Frequência (rad)');
ylabel('Fase (\circ)')



fig_comp_mag = figure;
semilogx((w), 20*log10(y));
grid on;
hold on;
semilogx(wout,20*log10(mag))
legend('Medição','Modelo')
xlabel('Frequência (rad)');
ylabel('Magnitude (dB)')



load('x_step.mat')
load('y_step.mat')

step_comp_fig = figure;

% plot(x_step_Time,x_step_Value)
aux = y_step_Time(x_step_Value>0);
 plot(y_step_Time(x_step_Value>0) - aux(1), y_step_Value(x_step_Value>0,1))
 hold on;
 grid on;
 plot(t_step_model,y_step_model)
 xlabel('Tempo(s)');
ylabel('Velocidade (rad/s)')
legend('Medição','Modelo')
axis([-inf inf 0 25])

ah = findobj('Type','figure'); % get all figures
for m=1:numel(ah) % go over all axes
  set(findall(ah(m),'-property','FontSize'),'FontSize',12)
%   axes_handle = findobj(ah(m),'type','axes');
%   saveas(ah(m),[axes_handle(1).Title.String '.png'])
end

saveas(fig_comp_phase,'images/comparison_phase.png')
saveas(fig_comp_mag,'images/comparison_mag.png')
saveas(step_comp_fig,'images/step_comparison.png')
