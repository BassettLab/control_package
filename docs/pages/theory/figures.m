%% Prepare Space
clear; clc;
set(groot,'defaulttextinterpreter','none');
FS = 16;


%% Figure 1: Fitzhugh-Nagumo model
% Parameters
dt = .01;
T = 100;
t = dt:dt:T;

% Equation
f = @(x) [x(1) - x(1).^3 /3 - x(2) + 0.5;...
          (x(1) + 0.8 - 0.7*x(2))/4];

% Evolution
X = zeros(2,T/dt); X(:,1) = [0;-1];
for i = 2:T/dt
    X(:,i) = X(:,i-1) + f(X(:,i-1))*dt;
end

% Plot
fig = figure(1); clf;
set(gcf,'color','w');
fSize = [30,10];
fName = 'fig_cycle.gif';
fig.PaperPositionMode = 'manual';
fig.PaperUnits = 'centimeters';
fig.PaperPosition = [0 0 fSize];
fig.PaperSize = fSize;
dT = 0.1;

C = lines(1);
nSV = 1;
set(gcf,'renderer','opengl','Position',[fig.Position(1:2) fSize],'Units','centimeters');
set(gcf,'renderer','opengl','Position',[fig.Position(1:2) fSize],'Units','centimeters');
vSep = .33;
vWid = .27;

for i = 1:100:size(X,2)
    subplot('position',[.05 .17 vWid .8]); cla;
    plot(t(1:i),X(1,1:i),'linewidth',1,'color',C);
    hold on; plot(t(i),X(1,i),'.','markersize',20,'color',C); hold off;
    legend('v(t)');
    xlabel('t'); ylabel('v'); axis([0 T*1.04 -2.2 2.2]);
    set(gca,'xtick',[0 T],'ytick',[-2 2],'fontsize',FS);
    
    subplot('position',[.05 .17 vWid .8] + [vSep 0 0 0]); cla;
    plot(t(1:i),X(2,1:i),'linewidth',1);
    hold on; plot(t(i),X(2,i),'.','markersize',20,'color',C); hold off;
    legend('w(t)');
    xlabel('t'); ylabel('w'); axis([0 T*1.04 -1.1 2.2]);
    set(gca,'xtick',[0 T],'ytick',[-1 2],'fontsize',FS);
    
    subplot('position',[.05 .17 vWid .8] + 2*[vSep 0 0 0]); cla;
    plot(X(1,1:i),X(2,1:i),'linewidth',1);
    hold on; plot(X(1,i),X(2,i),'.','markersize',20,'color',C); hold off;
    legend('(v(t),w(t))');
    xlabel('v'); ylabel('w'); axis([-2.2 2.2 -1.1 2.2]);
    set(gca,'xtick',[-2 2],'ytick',[-1 2],'fontsize',FS);
    drawnow;
    
    % Save
    frame = getframe(fig);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    % Write to the GIF File
    if nSV == 1
      imwrite(imind,cm,fName,'gif', 'Loopcount',inf,'DelayTime',dT);
      nSV = 0;
    else
      imwrite(imind,cm,fName,'gif','WriteMode','append','DelayTime',dT);
    end
end


%% Figure 2: 1-D example
% Parameters
dt = .01;
T = 5;
t = dt:dt:T;

% Equation
f = @(x) -x;

% Evolution
X = zeros(3,T/dt); X(:,1) = [1;-1;0];
for i = 2:T/dt
    X(:,i) = X(:,i-1) + f(X(:,i-1))*dt;
end

% Plot
fig = figure(2); clf;
set(gcf,'color','w');
fSize = [30,10];
fName = 'fig_1d.gif';
fig.PaperPositionMode = 'manual';
fig.PaperUnits = 'centimeters';
fig.PaperPosition = [0 0 fSize];
fig.PaperSize = fSize;
dT = 0.03;

nSV = 1;
set(gcf,'renderer','opengl','Position',[fig.Position(1:2) fSize],'Units','centimeters');
set(gcf,'renderer','opengl','Position',[fig.Position(1:2) fSize],'Units','centimeters');
vSep = .33;
vWid = .27;

for i = 1:3:size(X,2)
    subplot('position',[.21 .17 vWid .8] + 0*[vSep 0 0 0]); cla;
    CL = lines(3);
    hold on;
    plot(t(1:i),X(1,1:i),'linewidth',1,'color',CL(1,:));
    plot(t(1:i),X(2,1:i),'linewidth',1,'color',CL(2,:));
    plot(t(1:i),X(3,1:i),'linewidth',1,'color',CL(3,:));
    plot(t(i),X(1,i),'.','markersize',20,'color',CL(1,:));
    plot(t(i),X(2,i),'.','markersize',20,'color',CL(2,:));
    plot(t(i),X(3,i),'.','markersize',20,'color',CL(3,:));
    hold off;
    axis([0 T*1.04 [-1 1]*1.1]);
    xlabel('t'); ylabel('x'); ylim([-1 1]*1.1);
    set(gca,'xtick',[0 T],'ytick',[-1 1],'fontsize',FS);
    legend('x(t) at x(0) = 1','x(t) at x(0) = -1','x(t) at x(0) = 0');
    
    subplot('position',[.21 .17 vWid .8] + 1*[vSep 0 0 0]); cla;
    hold on;
    quiver(X(1,i),0,-X(1,i)/2,0,1,'color',CL(1,:));
    quiver(X(2,i),0,-X(2,i)/2,0,1,'color',CL(2,:));
    quiver(X(3,i),0,-X(3,i)/2,0,1,'color',CL(3,:));
    plot(X(1,i),0,'.','markersize',20,'color',CL(1,:));
    plot(X(2,i),0,'.','markersize',20,'color',CL(2,:));
    plot(X(3,i),0,'.','markersize',20,'color',CL(3,:));
    hold off;
    legend('dx/dt at x(0) = 1','dx/dt at x(0) = -1','dx/dt at x(0) = 1');
    xlabel('x'); axis([-1 1 -1 1]*1.1);
    set(gca,'xtick',[-1 1],'ytick',[],'fontsize',FS);
    drawnow;
    
    % Save
    frame = getframe(fig);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    % Write to the GIF File
    if nSV == 1
      imwrite(imind,cm,fName,'gif', 'Loopcount',inf,'DelayTime',dT);
      nSV = 0;
    else
      imwrite(imind,cm,fName,'gif','WriteMode','append','DelayTime',dT);
    end
end



%% Figure 3: 2D vector field
% Parameters
dt = .01;
T = 40;
t = dt:dt:T;

% Equation
f = @(x) [x(1) - x(1).^3 /3 - x(2) + 0.5;...
          (x(1) + 0.8 - 0.7*x(2))/4];

[Xv,Yv] = meshgrid(linspace(-2.4,2.4,31),linspace(-1.2,2.4,31));
dXv = zeros(size(Xv));
dYv = zeros(size(Yv));
for i = 1:size(Xv,1)
    for j = 1:size(Xv,1)
        dXY = f([Xv(i,j);Yv(i,j)]);
        dXv(i,j) = dXY(1);
        dYv(i,j) = dXY(2);
    end
end

% Evolution
X = zeros(2,T/dt); X(:,1) = [0;-1];
for i = 2:T/dt
    X(:,i) = X(:,i-1) + f(X(:,i-1))*dt;
end

% Plot
fig = figure(3); clf;
set(gcf,'color','w');
fSize = [30,10];
fName = 'fig_vector_field.gif';
fig.PaperPositionMode = 'manual';
fig.PaperUnits = 'centimeters';
fig.PaperPosition = [0 0 fSize];
fig.PaperSize = fSize;
dT = 0.05;

nSV = 1;
set(gcf,'renderer','opengl','Position',[fig.Position(1:2) fSize],'Units','centimeters');
set(gcf,'renderer','opengl','Position',[fig.Position(1:2) fSize],'Units','centimeters');
vSep = .33;
vWid = .27;
C = lines(1);

for i = 1:20:size(X,2)
    subplot('position',[.365 .17 vWid .8]); cla;
    plot(X(1,1:i),X(2,1:i),'linewidth',1,'color',C);
    hold on;
    quiver(Xv,Yv,dXv,dYv,1.5,'color',C);
    plot(X(1,i),X(2,i),'.','markersize',20,'color',C);
    hold off;
    xlabel('v'); ylabel('w'); axis([-2 2 -1 2]*1.2);
    set(gca,'xtick',[-2 2],'ytick',[-1 2],'fontsize',FS);
    drawnow;
    
    % Save
    frame = getframe(fig);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    % Write to the GIF File
    if nSV == 1
      imwrite(imind,cm,fName,'gif', 'Loopcount',inf,'DelayTime',dT);
      nSV = 0;
    else
      imwrite(imind,cm,fName,'gif','WriteMode','append','DelayTime',dT);
    end
end


%% Figure 4, State reconstruction
A = [-1 -2; 1 0];

delT = .01;
T = 1;
t = delT:delT:T;
X1 = zeros(2,length(t)); X1(:,1) = [1;0];
X2 = zeros(2,length(t)); X2(:,1) = [0;1];
X3 = zeros(2,length(t)); X3(:,end) = [.5;-.5];

% Simulate
for i = 2:length(t)
    X1(:,i) = expm(A*t(i))*X1(:,1);
    X2(:,i) = expm(A*t(i))*X2(:,1);
end

% Reconstruct
X3(:,1) = [X1(:,end) X2(:,end)]\X3(:,end);

for i = 2:length(t)-1
    X3(:,i) = expm(A*t(i))*X3(:,1);
end

fig = figure(4); clf;
set(gcf,'color','w');
fSize = [30,10];
fName = 'fig_reconstruction.png';
fig.PaperPositionMode = 'manual';
fig.PaperUnits = 'centimeters';
fig.PaperPosition = [0 0 fSize];
fig.PaperSize = fSize;
dT = 0.05;

nSV = 1;
set(gcf,'renderer','opengl','Position',[fig.Position(1:2) fSize],'Units','centimeters');
set(gcf,'renderer','opengl','Position',[fig.Position(1:2) fSize],'Units','centimeters');
vSep = .33;
vWid = .27;
C = lines(4);
[Xv,Yv] = meshgrid(linspace(-1.7,1.7,31),linspace(-1.7,1.7,31));

subplot('position',[.05 .17 vWid .8]); cla;
hold on;
plot(X1(1,1),X1(2,1),'.','markersize',20,'color',C(2,:));
plot(X2(1,1),X2(2,1),'.','markersize',20,'color',C(3,:));
plot(X1(1,end),X1(2,end),'o','markersize',8,'linewidth',2,'color',C(2,:));
plot(X2(1,end),X2(2,end),'o','markersize',8,'linewidth',2,'color',C(3,:));
plot(X3(1,end),X3(2,end),'o','markersize',8,'linewidth',2,'color',C(4,:));
plot(0,0,'k.','markersize',10);
quiver(Xv,Yv,A(1,1)*Xv+A(1,2)*Yv,A(2,1)*Xv+A(2,2)*Yv,1.5,'color',C(1,:));
plot(X1(1,:),X1(2,:),'linewidth',1,'color',C(2,:));
plot(X2(1,:),X2(2,:),'linewidth',1,'color',C(3,:));
hold off;
legend('x_1(0)','x_2(0)','x_1(T)','x_2(T)','x^*(T)','(0,0)','numcolumns',3,'location','southwest');
xlabel('x1'); ylabel('x2'); axis([-1 1 -1 1]*1.5);
set(gca,'xtick',[-1 1],'ytick',[-1 1],'fontsize',FS);

subplot('position',[.05 .17 vWid .8] + [vSep 0 0 0]); cla;
hl = 5;
hw = 5;
hold on;
h = annotation('arrow');
set(h,'parent',gca,'position',[0 0 X1(1,end) X1(2,end)]*.86,'color',C(2,:),...
               'linestyle','-','linewidth',1,'headwidth',hw,'headlength',hl);
h = annotation('arrow');
set(h,'parent',gca,'position',[0 0 X2(1,end) X2(2,end)]*.93,'color',C(3,:),...
               'linestyle','-','linewidth',1,'headwidth',hw,'headlength',hl);
h = annotation('arrow');
set(h,'parent',gca,'position',[0 0 X1(1,end) X1(2,end)]*X3(1,1),'color',C(2,:),...
               'linestyle','--','linewidth',1,'headwidth',hw,'headlength',hl);
h = annotation('arrow');
set(h,'parent',gca,'position',[0 0 X2(1,end) X2(2,end)]*X3(2,1),'color',C(3,:),...
               'linestyle','--','linewidth',1,'headwidth',hw,'headlength',hl);
h = annotation('arrow');
set(h,'parent',gca,'position',[[X1(1,end) X1(2,end)]*X3(1,1) [X2(1,end) X2(2,end)]*X3(2,1)*.88],'color',C(3,:),...
               'linestyle','--','linewidth',1,'headwidth',hw,'headlength',hl);
h = annotation('arrow');
set(h,'parent',gca,'position',[[X2(1,end) X2(2,end)]*X3(2,1) [X1(1,end) X1(2,end)]*X3(1,1)*.8],'color',C(2,:),...
               'linestyle','--','linewidth',1,'headwidth',hw,'headlength',hl);
axis([-1 1 -1 1]*1.5);
plot(X1(1,1),X1(2,1),'.','markersize',20,'color',C(2,:));
plot(X2(1,1),X2(2,1),'.','markersize',20,'color',C(3,:));
plot(X1(1,end),X1(2,end),'o','markersize',8,'linewidth',2,'color',C(2,:));
plot(X2(1,end),X2(2,end),'o','markersize',8,'linewidth',2,'color',C(3,:));
plot(X3(1,end),X3(2,end),'o','markersize',8,'linewidth',2,'color',C(4,:));
plot(X1(1,:),X1(2,:),'linewidth',1,'color',C(2,:));
plot(X2(1,:),X2(2,:),'linewidth',1,'color',C(3,:));
plot(0,0,'k.','markersize',10);
text(-.75,-.2,'a = -0.7','color',C(2,:),'fontsize',FS);
text(-.4,-.55,'b = -0.5','color',C(3,:),'fontsize',FS);
text(0,-1.05,'reconstruct target state','fontsize',FS,...
     'horizontalalignment', 'center');
text(0,-1.3,'using final states','fontsize',FS,...
     'horizontalalignment', 'center');
hold off;
xlabel('x1'); ylabel('x2');
set(gca,'xtick',[-1 1],'ytick',[-1 1],'fontsize',FS);


subplot('position',[.05 .17 vWid .8] + 2*[vSep 0 0 0]); cla;
hl = 5;
hw = 5;
hold on;
h = annotation('arrow');
set(h,'parent',gca,'position',[0 0 X1(1,1) X1(2,1)]*.96,'color',C(2,:),...
               'linestyle','-','linewidth',1,'headwidth',hw,'headlength',hl);
h = annotation('arrow');
set(h,'parent',gca,'position',[0 0 X2(1,1) X2(2,1)]*.96,'color',C(3,:),...
               'linestyle','-','linewidth',1,'headwidth',hw,'headlength',hl);
h = annotation('arrow');
set(h,'parent',gca,'position',[0 0 X1(1,1) X1(2,1)]*X3(1,1),'color',C(2,:),...
               'linestyle','--','linewidth',1,'headwidth',hw,'headlength',hl);
h = annotation('arrow');
set(h,'parent',gca,'position',[0 0 X2(1,1) X2(2,1)]*X3(2,1),'color',C(3,:),...
               'linestyle','--','linewidth',1,'headwidth',hw,'headlength',hl);
h = annotation('arrow');
set(h,'parent',gca,'position',[[X1(1,1) X1(2,1)]*X3(1,1) [X2(1,1) X2(2,1)]*X3(2,1)*.92],'color',C(3,:),...
               'linestyle','--','linewidth',1,'headwidth',hw,'headlength',hl);
h = annotation('arrow');
set(h,'parent',gca,'position',[[X2(1,1) X2(2,1)]*X3(2,1) [X1(1,1) X1(2,1)]*X3(1,1)*.94],'color',C(2,:),...
               'linestyle','--','linewidth',1,'headwidth',hw,'headlength',hl);
axis([-1 1 -1 1]*1.5);
plot(X1(1,1),X1(2,1),'.','markersize',20,'color',C(2,:));
plot(X2(1,1),X2(2,1),'.','markersize',20,'color',C(3,:));
plot(X3(1,1),X3(2,1),'.','markersize',20,'color',C(4,:));
plot(X1(1,end),X1(2,end),'o','markersize',8,'linewidth',2,'color',C(2,:));
plot(X2(1,end),X2(2,end),'o','markersize',8,'linewidth',2,'color',C(3,:));
plot(X3(1,end),X3(2,end),'o','markersize',8,'linewidth',2,'color',C(4,:));
plot(X1(1,:),X1(2,:),'linewidth',1,'color',C(2,:));
plot(X2(1,:),X2(2,:),'linewidth',1,'color',C(3,:));
plot(X3(1,:),X3(2,:),'linewidth',1,'color',C(4,:));
plot(0,0,'k.','markersize',10);
text(-.75,0.15,'a = -0.7','color',C(2,:),'fontsize',FS);
text(-1.46,-.25,'b = -0.5','color',C(3,:),'fontsize',FS);
text(0,-1.05,'use reconstruction to','fontsize',FS,...
     'horizontalalignment', 'center');
text(0,-1.3,'find new initial state','fontsize',FS,...
     'horizontalalignment', 'center');
hold off;
xlabel('x1'); ylabel('x2');
set(gca,'xtick',[-1 1],'ytick',[-1 1],'fontsize',FS);
drawnow;

% Save
fig.PaperPositionMode = 'manual';
fig.PaperUnits = 'centimeters';
fig.PaperPosition = [0 0 fSize];
fig.PaperSize = fSize;
saveas(fig, fName, 'png');


