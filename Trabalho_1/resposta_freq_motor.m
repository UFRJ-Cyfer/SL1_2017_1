fontsize = 12;
kt = 0.0502;
ke = kt;
jm = 221e-7;
la = 0.82e-3;
ra = 10.6;
num = kt;
den = [ra*jm ke*kt];

H = tf(num,den)
figure;
step(H)
fig_step=gcf;
grid on;
set(findall(fig_step,'-property','FontSize'),'FontSize',fontsize)

figure;
bode(H)
fig_bode=gcf;
grid on;
set(findall(fig_bode,'-property','FontSize'),'FontSize',fontsize)


saveas(fig_bode,'images/bode_response.png')
saveas(fig_step,'images/step_response.png')