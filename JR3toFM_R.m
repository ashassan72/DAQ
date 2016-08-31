function FMshe_R=JR3toFM_R(FM_R,handles)
abd_angle_R=(handles.Abd_angle_R)*pi/180;  % degrees to rad
elb_angle_R=pi-(handles.Elb_angle_R)*pi/180;  % degrees to rad
arm_length_R=(handles.Larm_R)/1000;    % mm to m
fore_length_R=(handles.Lfore_R)/1000;  % mm to m
z_offset_R=(handles.zoffset_R)/1000;    % mm to m

% Decouple FM
FM_R=DecoupleJR3FM(FM_R,[]);
% Convert to N and Nm
% FM(:,1:3)=FM(:,1:3)*9.81/2.2;
% FM(:,4:6)=FM(:,4:6)*9.81/2.2*2.54/100;
% Convert to right hand coordinate system
FM_R(:,[3 6])=-FM_R(:,[3 6]);
% Flip coordinate system to right arm if necessary
if strcmp(handles.arm_R,'left')
    FM_R(:,[2 4 6])=-FM_R(:,[2 4 6]);
end    
% Translate moments to the shoulder and elbow
[FMsh_R,FMe_R]=JR3toSHandE(FM_R,abd_angle_R,elb_angle_R,arm_length_R,fore_length_R,z_offset_R);
FMshe_R=[FMsh_R FMe_R(:,4)];


%---------------------------------------------------------------------------
function [FMsh_R,FMe_R]=JR3toSHandE(FMjr_R,abd_angle_R,elb_angle_R,arm_length_R,fore_length_R,z_offset_R)
% Function to transform the forces and moments from the JR3 coordinate system to the
% shoulder and elbow coordinate systems

% Calculate the Jacobian to translate the forces from the center of the JR3 to the middle
% of the epicondyles by distance z_offset
Jjtoe_R=[eye(3), Px([0 0 -z_offset_R]);
    zeros(3,3) eye(3)];
FMjr_R=(Jjtoe_R'*FMjr_R')';

% Two step transformation: first to elbow coordinate system and then to shoulder coordinate system
% Retojr = Ry(pi/2-abd)*Rz(pi)
% Rstoe = Rx(pi/2-elbow)
% Calculate the jacobian from elbow coordinates to JR3 coordinates
% JR3 coordinates: x - down, y - along forearm toward hand, z - away from forearm
% Elbow coordinates: x - flexion, y - pronation
R=roty(pi/2-abd_angle_R)*rotz(pi);
J=[R		Px([0 -fore_length_R 0])*R;
   zeros(3,3)  R];
FMe_R=(J'*FMjr_R')';

% Calculate the jacobian from shoulder coordinates to elbow coordinates
% Shoulder coordinates: x - flexion, y - abduction, z - external rotation
R=rotx(pi/2-elb_angle_R);
J=[R		Px([0 arm_length_R*sin(pi/2-elb_angle_R) -arm_length_R*cos(pi/2-elb_angle_R)])*R;
   zeros(3,3)  R];
FMsh_R=(J'*FMe_R')';


%-------------------------------------------------------------------------------------------
function P=Px(r)
P=[0 -r(3) r(2);
   r(3) 0  -r(1);
   -r(2) r(1) 0];



%--------------------------------------------------------------------------------------------
function [FM_R]=DecoupleJR3FM(FMraw_R,MaxLoad);
% DecoupleJR3FM  decouples the raw forces and moments from the JR3
% 
% 	[FM]=decouple(FMraw,MaxLoad)
% 
% 	FM: decoupled forces and moments in Newtons and Newton-meters [Fx Fy Fz Mx My Mz]
%  	FMraw: raw forces and moments in Volts [Fxraw Fyraw Fzraw Mxraw Myraw Mzraw]
%   MaxLoad: 0 - Use small load calibration matrix; 1 - use large load calibration matrix

[frows,fcol]=size(FMraw_R);
if (frows>fcol) FMraw_R=FMraw_R'; end

% Load calibration matrix: JR3Small - small load, JR3Large - large load
% This is not currently being used
%if ~MaxLoad,
%    load JR3Small
%    Matrix=JR3Small;
%else
%    load JR3Large
%    Matrix=JR3Large;
%end

% load JR3Large
% Matrix=JR3Large;
% FM=(Matrix*FMraw)';


% load JR3Small
% Matrix=JR3Small;
% FM=(Matrix*FMraw)';

%updated 11-9-05 Albert, to use new calibration matrix
load JR3LargeMC
Matrix=JR3LargeMC;
FM_R=(Matrix*FMraw_R)';

%-------------------------------------------------------------------------------------------
function [Rx]=rotx(th)
% vormen van een rotatiematrix voor rotaties rond de x-as
Rx(1,1)=1;
Rx(2,2)=cos(th);
Rx(2,3)=-sin(th);
Rx(3,2)= sin(th);
Rx(3,3)= cos(th);

%-------------------------------------------------------------------------------------------
function [Ry]=roty(th)
% vormen van een rotatiematrix voor rotaties rond de y-as
Ry(1,1)=cos(th);
Ry(1,3)=sin(th);
Ry(2,2)=1;
Ry(3,1)=-sin(th);
Ry(3,3)= cos(th);

%-------------------------------------------------------------------------------------------
function [Rz]=rotz(th)
% vormen van een rotatiematrix voor rotaties rond de z-as
Rz(1,1)=cos(th);
Rz(1,2)=-sin(th);
Rz(2,1)= sin(th);
Rz(2,2)= cos(th);
Rz(3,3)=1;

