l = [14.5, 10.7, 10.7, 9]; % Longitudes eslabones
% Definicion del robot RTB
L(1) = Link('revolute','alpha',pi/2,'a',0,   'd',l(1),'offset',0,   'qlim',[-3*pi/4 3*pi/4]);
L(2) = Link('revolute','alpha',0,   'a',l(2),'d',0,   'offset',pi/2,'qlim',[-3*pi/4 3*pi/4]);
L(3) = Link('revolute','alpha',0,   'a',l(3),'d',0,   'offset',0,   'qlim',[-3*pi/4 3*pi/4]);
L(4) = Link('revolute','alpha',0,   'a',0,   'd',0,   'offset',0,   'qlim',[-3*pi/4 3*pi/4]);
PhantomX = SerialLink(L,'name','Px');
% roty(pi/2)*rotz(-pi/2)
PhantomX.tool = [0 0 1 l(4); -1 0 0 0; 0 -1 0 0; 0 0 0 1];
ws = [-50 50];
% Graficar robot
%q = deg2rad([60, -70, 20, 15]);
%PhantomX.plot(q,'notiles','noname');
%hold on
%trplot(eye(4),'rgb','arrow','length',15,'frame','0')
%axis([repmat(ws,1,2) 0 60])
%%PhantomX.teach()

%%
qt = deg2rad([30, 45, 0, 56]);% con este q las matrices dan diferente a la original
%qt = deg2rad([60, -70, 20, 15]); % con este q todas las matrices dan lo mismo
Tt = PhantomX.fkine(qt) %Matriz original. En teoría todas las que obtengamos deberían ser iguales a esta
%%
my_q = invKinPhantom(Tt, l);
%%
%Codo abajo:
Ttabajo = PhantomX.fkine(my_q(1,:))
%%
%Codo arriba 
Ttarriba = PhantomX.fkine(my_q(2,:))
%%
q_profe = invKinPxC(Tt,l);
%%
%Codo abajo:
TtabajoProfe = PhantomX.fkine(q_profe(1,:))
%%
%Codo arriba 
TtarribaProfe = PhantomX.fkine(q_profe(2,:))

