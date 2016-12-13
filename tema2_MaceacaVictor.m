%x(t)=SUMA(de la -infint la infinit)[C(kw)*exp(jkwt)]
T=40; %perioada
D=13; %durata
N=25; %N-ul reprezinta capetele intervalului in care este cuprins k
%am luan N=25 pentru a pune in evidenta mai bine oscilatiile cand
%reconstruim semnalul dupa Componentele C(kw)exp(jkwt)
A=1; %amplitudinea semnalului
t=-100:0.01:100;
w=2*pi/T;
x=0;
y=square(2*pi/T*t,D/T*100);
c=zeros(size(2*N+1));
for k=-N:1:N;
    fun1=@(t) A.*exp(-1j*k*w*t); %am creat o functie cu expresia lui C(kw)
    %pe intervalul [0,D] unde x(t)=A;    
    fun2=@(t) (-A).*exp(-1j*k*w*t);%am creat o functie cu expresia lui C(kw)
    %pe intervalul [D,T] unde x(t)=-A;    
    c(k+N+1)=1/T*(integral(fun1,0,D)+integral(fun2,D,T)); %calculam C(kw)
    x=x+c(k+N+1)*exp(1j*k*w*t);%se aduna fiecare C(kw)*exp(jkwt) pt fiecare k
end
subplot(2, 1, 1)
stem((-N:N),abs(c)); title('Spectru de amplitudini');
subplot(2, 1,2)
plot(t, y, t, x); title('Semnalul (linie albastra) si semnalul reconstruit cu N componente (linie portocalie)')

%EXPLICATII:
%Cu cat N este mai mare cu atat semnalul obitinut prin "reconstruire"
%incepe sa arata ca semnalul dreptunghiular, ideal ar fi ca N sa fie egal
%cu infin, dar acest lucru nu se poate face in MatLab.