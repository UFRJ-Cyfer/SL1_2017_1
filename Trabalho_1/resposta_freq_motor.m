
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
fig_step=gcf;
grid on;

%Cria o diagrama de Bode
figure;
bode(H)
fig_bode=gcf;
grid on;

%Bota o tamanho das fontes das figuras em FontSize
fontsize = 12;
set(findall(fig_step,'-property','FontSize'),'FontSize',fontsize)
set(findall(fig_bode,'-property','FontSize'),'FontSize',fontsize)

%Salva as figuras do grafico de Bode e a resposta ao degrau
saveas(fig_bode,'images/bode_response.png')
saveas(fig_step,'images/step_response.png')