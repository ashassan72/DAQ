function varargout = TargetDAQ(varargin)
% TARGETDAQ Application M-file for TargetDAQ.fig
%    FIG = TARGETDAQ launch TargetDAQ GUI.
%    TARGETDAQ('callback_name', ...) invoke the named callback.

% Last Modified by GUIDE v2.5 02-Nov-2012 11:47:48

if nargin == 0  % LAUNCH GUI

	fig = openfig(mfilename,'reuse');

    % Generate a structure of handles to pass to callbacks, and store it. 
	handles = guihandles(fig);
    
%     diary('explog.txt')
    % Arm setup geometrical parameters
    % Note: the names for the edit text boxes and the parameter is the same except for an e prefix for
    % the edit text boxes
    % The default JR3 is the new one ('45E15A-RIC-A 1000N125')
    %%MODIFIED FOR 2 ARMS 8/15/16 ASH
    %Right Arm
    handles.sensmod_R='45E15A-RIC-A 1000N125'; set(handles.esensmod_R,'String','45E15A-RIC-A 1000N125');
    load JR3RICLarge; handles.sensmat_R=JR3RICLarge;
    handles.Abd_angle_R=75; set(handles.eAbd_angle_R,'String',num2str(handles.Abd_angle_R));  % shoulder abduction angle not used in current transformations
    handles.Elb_angle_R=90; set(handles.eElb_angle_R,'String',num2str(handles.Elb_angle_R)); % corresponds to elbow angle
    handles.Larm_R=300; set(handles.eLarm_R,'String',num2str(handles.Larm_R)); % corresponds to length of arm
    handles.Lfore_R=300; set(handles.eLfore_R,'String',num2str(handles.Lfore_R));  % corresponds to length of forearm (from JR3 center to elbow)
    handles.ztrans_R=100; set(handles.eztrans_R,'String',num2str(handles.ztrans_R));      % corresponds to z translation
    handles.arm_R='right'; set(handles.Right_arm_R,'Value',1); set(handles.Left_arm_R,'Value',0); % Corresponds to arm
    %Left Arm
    handles.sensmod_L='45E15A-U760-A 250L1125'; set(handles.esensmod_L,'String','45E15A-U760-A 250L1125');
    load JR3RICLarge; handles.sensmat_L=JR3RICLarge;
    handles.Abd_angle_L=75; set(handles.eAbd_angle_L,'String',num2str(handles.Abd_angle_L));  % shoulder abduction angle not used in current transformations
    handles.Elb_angle_L=90; set(handles.eElb_angle_L,'String',num2str(handles.Elb_angle_L)); % corresponds to elbow angle
    handles.Larm_L=300; set(handles.eLarm_L,'String',num2str(handles.Larm_L)); % corresponds to length of arm
    handles.Lfore_L=300; set(handles.eLfore_L,'String',num2str(handles.Lfore_L));  % corresponds to length of forearm (from JR3 center to elbow)
    handles.ztrans_L=100; set(handles.eztrans_L,'String',num2str(handles.ztrans_L));      % corresponds to z translation
    handles.arm_L='left'; set(handles.Right_arm_L,'Value',0); set(handles.Left_arm_L,'Value',1); % Corresponds to arm
    % Data acquisition parameters
    % AI channels - note that the number of AI channels must be the same as
    % the number of names in handles.daqnames
    handles.inchan=0:20; set(handles.eChannels,'String',num2str(length(handles.inchan)));
    % Note that the elbow moment (Me) is calculated from the raw FM and thus is not included on this list
%     handles.daqnames={'Ch0','Ch1','Ch2','Ch3','Ch4','Ch5','Ch6','Ch7','Ch8','Ch9','Ch10','Ch11','Ch12',...
%             'Ch13','Ch14','Ch15','Ch16','Ch17'};
    handles.daqnames={'FxR','FyR','FzR','MxR','MyR','MzR','Pulse','Ch7','Ch8','Ch9','Ch10','Ch11','Ch12',...
            'WR','WL','FxL','FyL','FzL','MxL','MyL','MzL'};
%     handles.daqnames={'Fx','Fy','Fz','Mx','My','Mz','AD','ID','PD','Trap','PM','Tri','Bic',...
%             'Brac','LD','Ch15','Ch16','Ch17'};
    handles.SRate=1000; set(handles.eSRate,'String',num2str(handles.SRate));
    handles.SLength=1; set(handles.eSLength,'String',num2str(handles.SLength));
    handles.filename='trial'; set(handles.efilename,'String',handles.filename);
    handles.itrial=1; set(handles.TrialNumber,'String',' ')
    handles.Timer=0; set(handles.eTimer,'String',num2str(handles.Timer))
    handles.PulseStart=0; set(handles.ePulseStart,'String',num2str(handles.PulseStart))
    handles.PulseStop=0; set(handles.ePulseStop,'String',num2str(handles.PulseStop))
    handles.stimflag=0; set(handles.Stim,'Value',0);
    handles.gainStim=5/70;
  
    % Button and menu parameters
    set(handles.Acquire,'Enable','Off')
    set(handles.Display_Target,'Enable','Off')
    set(handles.Target_Options,'Enable','Off')
    set(handles.Zero_FM,'Enable','Off')
    set(handles.ResetEnvelope,'Enable','Off')
    set(handles.SkipTarget,'Enable','Off')
    set(handles.SelectTarget,'Enable','Off')
    set(handles.FreezeDisplay,'Enable','Off'); handles.BlankDisp=0;

    % Target and envelope parameters
    %handles.FMoffset=zeros(6,1);
    handles.FMoffset_R=zeros(7,1); %LCM 10/30/12
    handles.FMoffset_L=zeros(7,1); %ASH 8/29/16
    handles.Target_x=0;
    handles.Target_y=0;
    handles.Target_t=10;
    handles.Target_z=0;
    handles.Target_s=3;
    handles.Cursor_s=3;
    handles.Pie_size=4;
    handles.th_zero =270;
    handles.Tenvelope=0;
    handles.EnvTargets=0;
    handles.RandTarg=[];
    handles.ZoomOpt=0;
    handles.ResetEnv=0;
    handles.lockmask=[0 0 0 0];
    handles.torquemask=[4 1 2 3];
    set(handles.EMGMaxes,'Value',0);
   
    % Update channel names on display
    handles.chnames=[{'FxR','FyR','FzR','FxL','FyL','FzL','Pulse'},handles.daqnames(7:end)];
    for i=1:length(handles.chnames)
        eval(['set(handles.ylabel' num2str(i) ', ''String'',handles.chnames{i})'])
    end
    guidata(fig, handles);
    
    if nargout > 0
		varargout{1} = fig;
	end

elseif ischar(varargin{1}) % INVOKE NAMED SUBFUNCTION OR CALLBACK

	try
		if (nargout)
			[varargout{1:nargout}] = feval(varargin{:}); % FEVAL switchyard
		else
			feval(varargin{:}); % FEVAL switchyard
		end
	catch
		disp(lasterr);
	end

end

%| ABOUT CALLBACKS:
%| GUIDE automatically appends subfunction prototypes to this file, and 
%| sets objects' callback properties to call them through the FEVAL 
%| switchyard above. This comment describes that mechanism.
%|
%| Each callback subfunction declaration has the following form:
%| <SUBFUNCTION_NAME>(H, EVENTDATA, HANDLES, VARARGIN)
%|
%| The subfunction name is composed using the object's Tag and the 
%| callback type separated by '_', e.g. 'slider2_Callback',
%| 'figure1_CloseRequestFcn', 'axis1_ButtondownFcn'.
%|
%| H is the callback object's handle (obtained using GCBO).
%|
%| EVENTDATA is empty, but reserved for future use.
%|
%| HANDLES is a structure containing handles of components in GUI using
%| tags as fieldnames, e.g. handles.figure1, handles.slider2. This
%| structure is created at GUI startup using GUIHANDLES and stored in
%| the figure's application data using GUIDATA. A copy of the structure
%| is passed to each callback.  You can store additional information in
%| this structure at GUI startup, and you can change the structure
%| during callbacks.  Call guidata(h, handles) after changing your
%| copy to replace the stored original so that subsequent callbacks see
%| the updates. Type "help guihandles" and "help guidata" for more
%| information.
%|
%| VARARGIN contains any extra arguments you have passed to the
%| callback. Specify the extra arguments by editing the callback
%| property in the inspector. By default, GUIDE sets the property to:
%| <MFILENAME>('<SUBFUNCTION_NAME>', gcbo, [], guidata(gcbo))
%| Add any extra arguments after the last argument, before the final
%| closing parenthesis.

% --------------------------------------------------------------------
function varargout = Abd_angle_Callback(h, eventdata, handles, varargin)
handles.Abd_angle=str2num(get(h,'String'));
guidata(h,handles)

% --------------------------------------------------------------------
function varargout = Elb_angle_Callback(h, eventdata, handles, varargin)
handles.Elb_angle=str2num(get(h,'String'));
guidata(h,handles)

% --------------------------------------------------------------------
function varargout = Larm_Callback(h, eventdata, handles, varargin)
handles.Larm=str2num(get(h,'String'));
guidata(h,handles)

% --------------------------------------------------------------------
function varargout = Lfore_Callback(h, eventdata, handles, varargin)
handles.Lfore=str2num(get(h,'String'));
guidata(h,handles)

% --------------------------------------------------------------------
function varargout = zoffset_Callback(h, eventdata, handles, varargin)
handles.ztrans=str2num(get(h,'String'));
guidata(h,handles)

% --------------------------------------------------------------------
function varargout = Right_arm_Callback(h, eventdata, handles, varargin)
handles.arm='right';
set(handles.Left_arm,'Value',0)
guidata(h,handles)

% --------------------------------------------------------------------
function varargout = Left_arm_Callback(h, eventdata, handles, varargin)
handles.arm='left';
set(handles.Right_arm,'Value',0)
guidata(h,handles)

% --------------------------------------------------------------------
function eChannels_Callback(h, eventdata, handles)
numchan=str2num(get(h,'String'));
% while numchan>18,
%     prompt={'This program is limited to 18 DAQ channels. Please enter the number of channels:'};
%     def={num2str(18)};
%     dlgTitle='Input # of channels';
%     lineNo=1;
%     answer=inputdlg(prompt,dlgTitle,lineNo,def);
%     if isempty(answer), numchan=18;
%     else numchan=str2num(answer{1});
%     end
%     set(handles.eChannels,'String',num2str(numchan));
% end
if numchan<length(handles.inchan)   % Hide plots
    handles.daqnames=handles.daqnames(1:numchan);
    handles.chnames=handles.chnames(1:numchan+1);
    for i=numchan+2:22
        eval(['cla(handles.axes' num2str(i) ')'])
        eval(['set(handles.axes' num2str(i) ',''Visible'',''off'')'])
        eval(['set(handles.label' num2str(i) ',''Visible'',''off'')'])
        eval(['set(handles.ylabel' num2str(i) ',''Visible'',''off'')'])
    end
%     eval(['set(handles.axes' num2str(numchan+1) ',''XTickLabelMode'',''auto'',''XTickMode'',''auto'')'])
else    % Unhide plots
    for i=8:numchan+1
        eval(['set(handles.axes' num2str(i) ',''Visible'',''on'')'])
        eval(['set(handles.label' num2str(i) ',''Visible'',''on'')'])
        eval(['set(handles.ylabel' num2str(i) ',''Visible'',''on'')'])
        handles.daqnames={handles.daqnames{:},['Ch',num2str(i-2)]};
    end
end
handles.inchan=0:numchan-1;
guidata(h,handles)

% --------------------------------------------------------------------
function varargout = SRate_Callback(h, eventdata, handles, varargin)
handles.SRate=str2num(get(h,'String'));
if isfield(handles,'ai')
    if strcmp(get(handles.ai,'running'),'On'), 
        stop(handles.ai)
        set([handles.ai handles.ao],'SampleRate', handles.SRate)
        handles.ActualRate = get(handles.ai,'SampleRate');
        set(handles.ai,'SamplesPerTrigger', handles.ActualRate*handles.SLength)
        set(handles.ai,'Timerfcn',{@localTimerAction,handles})
        start(handles.ai); trigger(handles.ai);
    else
        set([handles.ai handles.ao],'SampleRate', handles.SRate)
        handles.ActualRate = get(handles.ai,'SampleRate');
        set(handles.ai,'SamplesPerTrigger', handles.ActualRate*handles.SLength)
    end        
end
% set(handles.Acquire,'Enable','Off')
% set(handles.Display_Target,'Enable','Off')
guidata(h,handles)

% --------------------------------------------------------------------
function varargout = SLength_Callback(h, eventdata, handles, varargin)
handles.SLength=str2num(get(h,'String'));
if isfield(handles,'ai')
%     uiwait(msgbox('DAQ settings have changed. Reinitialize DAQ','TargetDAQ','warn','modal'));
    if strcmp(get(handles.ai,'running'),'On'), 
        stop(handles.ai)
        set(handles.ai,'SamplesPerTrigger', handles.ActualRate*handles.SLength)
        set(handles.ai,'Timerfcn',{@localTimerAction,handles})
        start(handles.ai); trigger(handles.ai)
    else
        set(handles.ai,'SamplesPerTrigger', handles.ActualRate*handles.SLength)
    end        
end
% set(handles.Acquire,'Enable','Off')
% set(handles.Display_Target,'Enable','Off')
guidata(h,handles)

% --------------------------------------------------------------------
function varargout = Timer_Callback(h, eventdata, handles, varargin)
handles.Timer=str2num(get(h,'String'));
guidata(h,handles)

% --------------------------------------------------------------------
function ePulseStart_Callback(h, eventdata, handles)
handles.PulseStart=str2num(get(h,'String'));
if isfield(handles,'ao')
    if strcmp(get(handles.ao,'running'),'On'), 
        stop(handles.ao)
        if ~handles.stimflag
            putdata(handles.ao,[zeros(handles.PulseStart*handles.SRate,1);5*ones((handles.PulseStop-handles.PulseStart)*handles.SRate,1);0]);
        else
            % Thierry had set the sampling rate to 1/4 of handles.SRate. Is
            % it necessary?
            % generate a 100 ms TTL pulse and a second 100 ms TTL pulse after 500 ms
            data1=[5*ones(0.1*handles.SRate,1);zeros(0.4*handles.SRate,1);5*ones(0.1*handles.SRate,1);0];
            data2=[(handles.PulseStart*handles.gainStim)*ones(length(data1)-1,1);0];
            putdata(handles.ao,[data1 data2]);

        end
    end
end
guidata(h,handles)

% --------------------------------------------------------------------
function ePulseStop_Callback(h, eventdata, handles)
handles.PulseStop=str2num(get(h,'String'));
if isfield(handles,'ao')
    if strcmp(get(handles.ao,'running'),'On'), 
        stop(handles.ao)
        putdata(handles.ao,[zeros(handles.PulseStart*handles.SRate,1);5*ones((handles.PulseStop-handles.PulseStart)*handles.SRate,1);0]);
    end
end
guidata(h,handles)

% --------------------------------------------------------------------
function varargout = filename_Callback(h, eventdata, handles, varargin)
handles.filename=get(h,'String');
handles.itrial=1; set(handles.TrialNumber,'String',num2str(handles.itrial))
if exist([handles.filename num2str(handles.itrial) '.daq'],'file')==2,
    response=questdlg('The data file already exists. Do you want to overwrite it?','TargetDAQ','Yes','No','No');
    if strcmp(response,'No')
        prompt={'Enter the file name:','Enter the trial number:'};
        def={handles.filename num2str(handles.itrial)};
        dlgTitle='Input File Name';
        lineNo=1;
        answer=inputdlg(prompt,dlgTitle,lineNo,def);
        handles.filename=answer{1};set(handles.efilename,'String',handles.filename);
        handles.itrial=str2num(answer{2}); set(handles.TrialNumber,'String',num2str(handles.itrial))
    end
end

if isfield(handles,'ai')
    %     msgbox('DAQ settings have changed. Reinitialize DAQ','TargetDAQ','warn');
    if strcmp(get(handles.ai,'running'),'On')
        stop(handles.ai)
        set(handles.ai,'LogFileName', [handles.filename num2str(handles.itrial) '.daq'])
        set(handles.ai,'Timerfcn',{@localTimerAction,handles})
        start(handles.ai); trigger(handles.ai)
    else
        set(handles.ai,'LogFileName', [handles.filename num2str(handles.itrial) '.daq'])
    end
end
guidata(h,handles)

% --------------------------------------------------------------------
function varargout = TrialNumber_Callback(h, eventdata, handles, varargin)
handles.itrial=str2num(get(h,'String'));
if exist([handles.filename num2str(handles.itrial) '.daq'],'file')==2,
    response=questdlg('The data file already exists. Do you want to overwrite it?','TargetDAQ','Yes','No','No');
    if strcmp(response,'No')
        prompt={'Enter the file name:','Enter the trial number:'};
        def={handles.filename num2str(handles.itrial)};
        dlgTitle='Input File Name';
        lineNo=1;
        answer=inputdlg(prompt,dlgTitle,lineNo,def);
        handles.filename=answer{1};set(handles.efilename,'String',handles.filename);
        handles.itrial=str2num(answer{2}); set(handles.TrialNumber,'String',num2str(handles.itrial))
    end
end

if isfield(handles,'ai')
    if strcmp(get(handles.ai,'running'),'On')
        stop(handles.ai)
        set(handles.ai,'LogFileName', [handles.filename num2str(handles.itrial) '.daq'])
        set(handles.ai,'Timerfcn',{@localTimerAction,handles})
        start(handles.ai); trigger(handles.ai)
    else
        set(handles.ai,'LogFileName', [handles.filename num2str(handles.itrial) '.daq'])
    end
end
guidata(h,handles)

% --------------------------------------------------------------------
function PlayBeep(h,event,handles)
global eventcnt
eventcnt=eventcnt+1;

if (eventcnt==2),
    % Read in a sound file
    %[y,fs,bits]=wavread('c:\windows\media\Utopia Default.wav');
%     [y,fs,bits]=wavread('c:\windows\media\Windows XP Default.wav');
    [y,fs,bits]=wavread('beep.wav');
    wavplay(y,fs);
end

% --------------------------------------------------------------------
function varargout = Init_Callback(h, eventdata, handles, varargin)
% Function to initialize the data acquisition
global eventcnt
eventcnt=0;

% TrialNumber_Callback(handles.TrialNumber, eventdata, handles,[]);
filename_Callback(handles.efilename, eventdata, handles,[]);
handles=guidata(h);

% if strcmp(lower(get(handles.Display_Target,'Enable')),'on')
%     Display_Target_Callback(handles.Display_Target, eventdata, handles);
% end

% Set acquisition parameters
% Create analog input object for regular data acquisition
handles=InitDAQ(handles,'beep');

% Create analogoutput object
handles.ao = analogoutput('nidaq', 1);
if ~handles.stimflag, addchannel(handles.ao,0); else addchannel(handles.ao,0:1); end
set(handles.ao,'SampleRate',handles.SRate,'TriggerType','Manual');

% set(handles.TrialNumber,'String',num2str(handles.itrial))
set(handles.Acquire,'Enable','On')
set(handles.Display_Target,'Enable','On')
guidata(h,handles)
varargout{1}=handles;


function handles=InitDAQ(handles,timerfcn)

if isfield(handles,'ai'), stop(handles.ai); delete(handles.ai); rmfield(handles,'ai'); end

handles.ai = analoginput('nidaq', 1);
%set([handles.ai handles.ao],'SampleRate',SRate);
set(handles.ai,'SampleRate',handles.SRate);
handles.ActualRate = get(handles.ai,'SampleRate');
set(handles.ai, 'SamplesPerTrigger',handles.SLength*handles.ActualRate,...
    'LogFileName', [handles.filename num2str(handles.itrial) '.daq'],...
    'LogToDiskMode', 'Index',...
    'LoggingMode', 'Disk&Memory',...
    'TimerPeriod', 0.1,...
    'TriggerType', 'Manual');
switch timerfcn
case 'beep'
    set(handles.ai,'Timerfcn',@PlayBeep)
case 'rtd'
    set(handles.ai,'Timerfcn',{@localTimerAction,handles})
end

aichan=floor(handles.inchan/8)*16+rem(handles.inchan,8);
chan = addchannel(handles.ai,aichan,handles.inchan+1,{handles.daqnames{handles.inchan+1}});   

% --------------------------------------------------------------------
function varargout = Acquire_Callback(h, eventdata, handles, varargin)
global eventcnt
eventcnt=0;

% Make sure the data acquisition is not running. There is some bug that
% triggers data acquisition at irregular intervals for random sampling
% lengths
% waittilstop(handles.ai,60)
set(handles.TrialNumber,'String',num2str(handles.itrial))   % Update the trial number
set(handles.Acquire,'Enable','Off')

switch get(handles.Display_Target,'Checked')
% Regular data acquisition, no real time display
case {'Off','off'}
    if handles.PulseStop>0,
        putdata(handles.ao,[zeros(handles.PulseStart*handles.SRate,1);5*ones((handles.PulseStop-handles.PulseStart)*handles.SRate,1);0]);
        start([handles.ai handles.ao]); tic; trigger([handles.ai handles.ao]);
    elseif handles.stimflag
        % generate a 100 ms TTL pulse and a second 100 ms TTL pulse after 400 ms
        data1=[zeros(0.5*handles.SRate,1);5*ones(0.1*handles.SRate,1);zeros(0.4*handles.SRate,1);5*ones(0.1*handles.SRate,1);0];
        data2=[zeros(0.5*handles.SRate,1);(handles.PulseStart*handles.gainStim)*ones(0.6*handles.SRate,1);0];
        putdata(handles.ao,[data1 data2]);
        start([handles.ai handles.ao]); tic; trigger([handles.ai handles.ao]);    
    else start(handles.ai); tic; trigger(handles.ai);
    end
    handles=localDisplayData(handles);
    while toc<=handles.Timer+handles.SLength
    end
case {'On','on'}
%     if strcmp(lower(get(handles.ai,'Running')),'on'),
%         stop(handles.ai)
%         delete(handles.ai)
%         rmfield(handles,'ai');
%     end
    if isinf(get(handles.ai,'SamplesPerTrigger'))
        handles=InitDAQ(handles,'rtd');
    else
        waittilstop(handles.ai,handles.SLength)
    end
%     disp(['itrial=' num2str(handles.itrial) ' LogFileName=' get(handles.ai,'LogFileName')])
    if isempty(findstr(get(handles.ai,'LogFileName'),num2str(handles.itrial))),
        disp('Trial number mismatch!!')
        set(handles.ai,'LogFileName',[handles.filename num2str(handles.itrial) '.daq'])
    end
    tdhan=guidata(handles.tdh);
    
    if handles.PulseStop>0,
        putdata(handles.ao,[zeros(handles.PulseStart*handles.SRate,1);5*ones((handles.PulseStop-handles.PulseStart)*handles.SRate,1);0]);
        start([handles.ai handles.ao]); tic; trigger([handles.ai handles.ao]);
    elseif handles.stimflag
        % generate a 100 ms TTL pulse and a second 100 ms TTL pulse after 500 ms
        data1=[zeros(0.5*handles.SRate,1);5*ones(0.1*handles.SRate,1);zeros(0.4*handles.SRate,1);5*ones(0.1*handles.SRate,1);0];
        data2=[zeros(0.5*handles.SRate,1);(handles.PulseStart*handles.gainStim)*ones(0.6*handles.SRate,1);0];
        putdata(handles.ao,[data1 data2]);
        start([handles.ai handles.ao]); tic; trigger([handles.ai handles.ao]);    
    else start(handles.ai); tic; trigger(handles.ai);
    end
    handles=localDisplayData(handles);
    while toc<=handles.Timer+handles.SLength   
        set(tdhan.TimerDisp,'String',num2str(handles.Timer+handles.SLength-round(toc)))
    end
    set(tdhan.TimerDisp,'String',[])
end
set(handles.Acquire,'Enable','On')  
handles.itrial=handles.itrial+1;
guidata(h,handles)

% --------------------------------------------------------------------
function varargout = Zero_FM_Callback(h, eventdata, handles, varargin)
% Function to zero load cell
if strcmp(get(handles.ai,'running'),'On')
    blocksize=floor(get(handles.ai,'SampleRate')/10);
    data = peekdata(handles.ai, blocksize);
else
    set(handles.ai,'SamplesPerTrigger',0.01*handles.SRate,'LoggingMode','Memory')
    start(handles.ai); trigger(handles.ai)
    data = getdata(handles.ai);
    set(handles.ai, 'SamplesPerTrigger',handles.SLength*handles.ActualRate,...
    'LogFileName', [handles.filename num2str(handles.itrial) '.daq'],...
    'LogToDiskMode', 'Index',...
    'LoggingMode', 'Disk&Memory',...
    'TriggerType', 'Manual')
end
tdhan=guidata(handles.tdh);
if handles.Tenvelope
    set(tdhan.lh(9),'Xdata',[],'Ydata',[])
    drawnow
end
% handles.FMoffset=mean(data(:,1:6));
handles.FMoffset_R=mean(data(:,[1:6,14])); %added two channels for WF/WE and FF/FE
handles.FMoffset_L=mean(data(:,[16:21,15]));  
%Update timer function in ai
guidata(h,handles)
set(handles.ai,'Timerfcn', {@localTimerAction,handles})

% --------------------------------------------------------------------
function handles = Target_Options_Callback(h, eventdata, handles, varargin)
dlgh=TarOptDlg(handles);
dlghandles=guidata(dlgh);

switch dlghandles.action
case 'cancel'
    % no action
case 'ok'
	% Save changes to target options
    handles.Target_x=str2num(get(dlghandles.Target_x,'String'));
    handles.Target_y=str2num(get(dlghandles.Target_y,'String'));
    handles.Target_t=str2num(get(dlghandles.Target_theta,'String'));
    handles.Target_z=str2num(get(dlghandles.Target_zoom,'String'));
    handles.Target_s=str2num(get(dlghandles.Target_size,'String'));
    handles.Cursor_s=str2num(get(dlghandles.Cursor_size,'String'));
    handles.Pie_size=str2num(get(dlghandles.Pie_size,'String'));
    handles.th_zero =str2num(get(dlghandles.theta_zero,'String'));
    handles.Tenvelope=get(dlghandles.Tenvelope,'Value');
    handles.ZoomOpt=get(dlghandles.Zoom_Option,'Value');
    handles.lockmask=dlghandles.lockmask;
    handles.torquemask=dlghandles.torquemask;
    handles.EnvTargets=get(dlghandles.EnvTargets,'Value');
end
handles=InitTargetDisplay(h,handles);
set(handles.ai,'Timerfcn', {@localTimerAction,handles})
guidata(h,handles)
% Close Target Options dialog box
delete(dlgh)

% --------------------------------------------------------------------
function varargout = Display_Target_Callback(h, eventdata, handles, varargin)

tdflag=get(h,'Checked');
switch tdflag
case {'Off','off'}
    set(h,'Checked','On')
    set(handles.Target_Options,'Enable','On')
    set(handles.Zero_FM,'Enable','On')
    set(handles.FreezeDisplay,'Enable','On')
    % Launch Target Display
    handles.tdh=TargetDisplay(h);
    handles.FM_R=[];handles.FM_L=[];
    guidata(h,handles)
    
    % Launch target options dialog
    handles=Target_Options_Callback(h, eventdata, handles);
    if handles.Tenvelope, 
        set(handles.ResetEnvelope,'Enable','On');
        set(handles.SkipTarget,'Enable','On')
        set(handles.SelectTarget,'Enable','On')
    end
    set(handles.ai,'SamplesPerTrigger',Inf,'LoggingMode', 'Memory')
    set(handles.ai,'Timerfcn', {@localTimerAction,handles})
    start(handles.ai); trigger(handles.ai)
case {'On','on'}
    set(h,'Checked','Off')
    set(handles.Target_Options,'Enable','Off')
    set(handles.Zero_FM,'Enable','Off')
    set(handles.ResetEnvelope,'Enable','Off'); 
    set(handles.SkipTarget,'Enable','Off')
    set(handles.SelectTarget,'Enable','Off')
    set(handles.FreezeDisplay,'Enable','Off')
    % Stop ai to avoid warning messages
%     if strcmp(get(handles.rtai,'running'),'On')
%         stop(handles.rtai); delete(handles.rtai); 
%         rmfield(handles,'rtai');
%     end
    handles=InitDAQ(handles,'beep');
    disp('Closing Target Display')
    delete(handles.tdh); % Close Target Display

end
guidata(h,handles)

% --------------------------------------------------------------------
function handles=InitTargetDisplay(h,handles)
% Function to initialize the target display

tdhan=guidata(handles.tdh);

if ~isempty(tdhan.lh),
    delete(tdhan.lh)
    tdhan.lh=[];
end

%Initialize target graphics objects (x:cursor, xt:target, xp:pie on cursor
% xd:dial, xc:cone)

% Cursor - this object changes with time
handles.x=Circle(handles.Cursor_s,[0 0]);
handles.Pie_center=90;
% Pie and dial on cursor - these objects change with time
if handles.Target_t == 0,
    handle.th_zero=90;
    handles.Nmtodeg=180/(5*handles.Pie_size);
else
% If the dial zero is at 90 degrees, set the pie width to 60 degrees.
    if handles.th_zero==90,
        handles.Nmtodeg=60/(handles.Pie_size);
    else
        handles.Nmtodeg=abs(handles.Pie_center-handles.th_zero)/abs(handles.Target_t);
    end
end
% else 
%     handles.Pie_center=-90;
%     handles.Nmtodeg=(handles.th_zero-handles.Pie_center)/abs(handles.Target_t);
% end

xp=Circle(handles.Cursor_s,[0 0],[handles.Pie_center+handles.Nmtodeg*[-handles.Pie_size handles.Pie_size]/2 handles.th_zero]);
handles.xp=[0 0;xp(1,:);0 0;xp(2,:)];
xd=[0 0;xp(3,:)];

axes(tdhan.axes1)

% Plot cursor
hLine(1)=line('Parent',tdhan.axes1,'Xdata',handles.x(:,1),'Ydata',handles.x(:,2),'Color','g','LineWidth',2);
hLine(2)=line('Parent',tdhan.axes1,'Xdata',handles.xp(:,1),'Ydata',handles.xp(:,2),'Color','y','LineWidth',3);
hLine(3)=line('Parent',tdhan.axes1,'Xdata',xd(:,1),'Ydata',xd(:,2),'Color','r','LineWidth',3);
if ~handles.Tenvelope   % Plot target graphics
    % Target - this object doesn't change with time
    if strcmp(handles.arm,'right')
        xt=Circle(handles.Target_s,[-handles.Target_x handles.Target_y]);
    else
        xt=Circle(handles.Target_s,[handles.Target_x handles.Target_y]);
    end
    
    % Cone from cursor to target - this object is fixed
    if (handles.Target_y==0 & handles.Target_x==0), 
        xc=zeros(4,2);
    else
        d=norm([handles.Target_x handles.Target_y]);
        if strcmp(handles.arm,'right')
            thc=(atan2(handles.Target_y,-handles.Target_x)+[asin(handles.Target_s/d) -asin(handles.Target_s/d)])*180/pi;
        else
            thc=(atan2(handles.Target_y,handles.Target_x)+[asin(handles.Target_s/d) -asin(handles.Target_s/d)])*180/pi;
        end
        xc=Circle(d,[0 0],thc);xc=[0 0;xc(1,:);0 0;xc(2,:)];
    end   
    
    hLine(4)=line('Parent',tdhan.axes1,'Xdata',xt(:,1),'Ydata',xt(:,2),'Color','r','LineWidth',2);
    hLine(5)=line('Parent',tdhan.axes1,'Xdata',xc(:,1),'Ydata',xc(:,2),'Color','m','LineWidth',2);
    if handles.ZoomOpt,
        % Zoom target - this object changes with time
        handles.xz=[Circle(1.1*handles.Target_z,[0 0]); Circle(0.9*handles.Target_z,[0 0])];
        hLine(6)=line('Parent',tdhan.axes1,'Xdata',handles.xz(:,1),'Ydata',handles.xz(:,2),'Color','w');
    end        
    lim=round(max(abs([handles.Target_x handles.Target_y]))+1.1*handles.Target_s);
    set(tdhan.axes1,'XLim',[-lim lim],'YLim',[-lim lim])
else    % Set envelope graphics
    limx=round(handles.Target_x + 1.1*handles.Target_s);  
    limy=round(handles.Target_y + 1.1*handles.Target_s);  
    % Plot coordinate axes (4 - x-axis, 5 - y-axis) - fixed in time
    hLine(4)=line('Parent',tdhan.axes1,'Xdata',[-limx(1) limx(2)],'Ydata',[0 0],'Color','w','LineWidth',1);
    hLine(5)=line('Parent',tdhan.axes1,'Xdata',[0 0],'Ydata',[-limy(2) limy(1)],'Color','w','LineWidth',1);
    % Plot arrows on coordinate axes (6 - x-axis, 7 - y-axis)
    if strcmp(handles.arm,'right')
        hLine(6)=line('Parent',tdhan.axes1,'Xdata',-limx(1),'Ydata',0,'Color','w','Marker','<','MarkerFaceColor','w');
    else
        hLine(6)=line('Parent',tdhan.axes1,'Xdata',limx(2),'Ydata',0,'Color','w','Marker','>','MarkerFaceColor','w');
    end
    hLine(7)=line('Parent',tdhan.axes1,'Xdata',0,'Ydata',limy(1),'Color','w','Marker','^','MarkerFaceColor','w');
    % Plot maximum boundary rectangle
    hLine(8)=line('Parent',tdhan.axes1,'Xdata',[-handles.Target_x(1) handles.Target_x(2) handles.Target_x(2) -handles.Target_x(1) -handles.Target_x(1)],...
        'Ydata',[handles.Target_y(1) handles.Target_y(1) -handles.Target_y(2) -handles.Target_y(2) handles.Target_y(1)],'Color','r','LineWidth',10);
    axis 'equal'
    set(tdhan.axes1,'XLim',[-limx(1) limx(2)],'YLim',[-limy(2) limy(1)])
    % Initialize envelope (9) and maximum envelope (10)
    hLine(9)=line('Parent',tdhan.axes1,'Xdata',0,'Ydata',0,'Color','w','LineWidth',2);
    if isfield(handles,'MaxEnv')
        [x,y]=pol2cart((1:360)*pi/180,handles.MaxEnv);
        hLine(10)=line('Parent',tdhan.axes1,'Xdata',x,'Ydata',y,'Color','b','LineWidth',2);
    else
        hLine(10)=line('Parent',tdhan.axes1,'Xdata',0,'Ydata',0,'Color','b','LineWidth',2);
    end
    if handles.EnvTargets
%         handles.RandTarg=15*reshape(repmat(randperm(24),2,1),48,1);
%       Cut number of targets to 12 for stroke subjects
        handles.RandTarg=30*reshape(repmat(randperm(12),2,1),24,1);
%         handles.RandTarg=[315 315 240 240 210 210];
        handles.RandTargCnt=1;
        theta=handles.RandTarg(handles.RandTargCnt);
        [x2,y2]=pol2cart(theta*pi/180,handles.MaxEnv(theta));
        % Cone from cursor to target - this object is fixed
        d=handles.MaxEnv(theta);
        if (y2==0 & x2==0), xc=zeros(4,2);
        else xc=Circle(d,[0 0],theta+[7.5 -7.5]);xc=[0 0;xc(1,:);0 0;xc(2,:)];
        end
        xt=Circle(d*sin(7.5*pi/180),[x2 y2]);
        
        hLine(11)=line('Parent',tdhan.axes1,'Xdata',xt(:,1),'Ydata',xt(:,2),'Color','r','LineWidth',2);
        hLine(12)=line('Parent',tdhan.axes1,'Xdata',xc(:,1),'Ydata',xc(:,2),'Color','m','LineWidth',2);
        hLine(13)=line('Parent',tdhan.axes1,'Xdata',[],'Ydata',[],'Color','y','Marker','o','MarkerFaceColor','y','MarkerSize',18);
        for i=1:length(handles.RandTarg)/2
            eval(['set([handles.ST' num2str(i) '],''Label'',''' num2str(handles.RandTarg(2*i-1)) ''')'])
        end
        set(handles.ST1,'Checked','on')
    end        
end

tdhan.lh=hLine;
guidata(handles.tdh,tdhan)

% --------------------------------------------------------------------
function handles=Init_RTAI(h,handles)
% This function is not used in the current version of the program
% Function to initialize the real time data acquisition object
inchan=0:18;
SRate=str2num(get(handles.SRate,'String'));
SLength=str2num(get(handles.SLength,'String'));

handles.rtai=analoginput('nidaq',1);
%handles.rtai=analoginput('winsound');
set(handles.rtai,'SampleRate',SRate);
ActualRate = get(handles.ai,'SampleRate');
set(handles.rtai,...
    'SamplesPerTrigger', floor(ActualRate/10),...
    'Timerfcn', {@localTimerAction,handles},...
    'TimerPeriod', 0.1,...
    'TriggerRepeat', 1,...
    'TriggerType', 'Manual');

aichan=floor(handles.inchan/8)*16+rem(handles.inchan,8);
chan = addchannel(handles.rtai,aichan);   

% ---------------------------------------------------------

function localTimerAction(h,event,handles)
global eventcnt

if strcmp(get(handles.ai,'Running'),'Off'), return; end
eventcnt=eventcnt+1;

% AMA 2/22/12 Used for common drive experiment
% if (eventcnt==2 | eventcnt==60 | eventcnt==120),
if (eventcnt==2),
    % Read in the sound file
    [y,fs,bits]=wavread('beep.wav');
    wavplay(y,fs);
end

if handles.BlankDisp & (eventcnt > 10*(handles.PulseStart-0.2))
    return
end

blocksize=floor(get(handles.ai,'SampleRate')/100);

data = peekdata(handles.ai, blocksize);
if isempty(data), return; end

% Remove offset forces and moments
% [m,n]=size(data(:,1:6));
% FM=JR3toFM(data(:,1:6)-(diag(handles.FMoffset)*ones(n,m))',handles);
[m,n]=size(data(:,[1:6,14]));
FMhandbase_R = data(:,[1:6,14]) - (diag(handles.FMoffset_R)*ones(n,m))';
FMhand_R = JR3toFM_L(FMhandbase_R(:,1:6),handles);
FMhand_R = [FMhand_R FMhandbase_R(:,14)];
FMhandbase_L = data(:,[16:21,15]) - (diag(handles.FMoffset_L)*ones(n,m))';
FMhand_L = JR3toFM_L(FMhandbase_L(:,16:21),handles);
FMhand_L = [FMhand_L FMhandbase_L(:,15)];
%FMhand(:,7) = FMhand(:,7)*10; %to increase scaling for feedback %LCM

if ~handles.Tenvelope, 
    %M=mean(FM(:,handles.torquemask+3)).*(~handles.lockmask);
    M_R=mean(FMhand_R(:,handles.torquemask+3)).*(~handles.lockmask);
     M_L=mean(FMhand_L(:,handles.torquemask+3)).*(~handles.lockmask);
    if strcmp(handles.arm_R,'right'), M_R(1)=-M_R(1); end
    localDisplayTarget(M_R,handles,'g');localDisplayTarget(M_L,handles,'g');
else 
    %M=FM(:,handles.torquemask(1:3)+3).*repmat(~handles.lockmask(1:3),length(FM),1);
    M_R=FMhand_R(:,handles.torquemask(1:3)+3).*repmat(~handles.lockmask(1:3),length(FMhand_R),1); %added for wrist 10/30/12 LCM
    M_L=FMhand_R(:,handles.torquemask(1:3)+3).*repmat(~handles.lockmask(1:3),length(FMhand_L),1);
    if strcmp(handles.arm_R,'right'), M_R(1)=-M_R(1); end
    localDisplayEnvelope_L(M_R,handles);localDisplayEnvelope_L(M_L,handles);
end

% --------------------------------------------------------------------
function localDisplayTarget_R(mFM_R, handles, color)

tdhan=guidata(handles.tdh); % Get Target Display handles structure
if ~handles.ZoomOpt,
    xd=Circle(handles.Cursor_s,mFM_R(1:2),handles.Nmtodeg*mFM_R(3)+handles.th_zero);xd=[mFM_R(1:2);xd];
    set(tdhan.lh(1),'Xdata',handles.x(:,1)+mFM_R(1),'Ydata',handles.x(:,2)+mFM_R(2),'Color',color)
    set(tdhan.lh(2),'Xdata',handles.xp(:,1)+mFM_R(1),'Ydata',handles.xp(:,2)+mFM_R(2))
    set(tdhan.lh(3),'Xdata',xd(:,1),'Ydata',xd(:,2))
else
    x=Circle(handles.Cursor_s + mFM_R(4),mFM_R(1:2));
    xp=Circle(handles.Cursor_s + mFM_R(4),[0 0],[handles.Pie_center+handles.Nmtodeg*[-handles.Pie_size handles.Pie_size]/2 handles.th_zero]);
    xp=[0 0;xp(1,:);0 0;xp(2,:)];
    xd=Circle(handles.Cursor_s + mFM_R(4),mFM_R(1:2),handles.Nmtodeg*mFM_R(3)+handles.th_zero);xd=[mFM_R(1:2);xd];
    set(tdhan.lh(1),'Xdata',x(:,1),'Ydata',x(:,2),'Color',color)
    set(tdhan.lh(2),'Xdata',xp(:,1)+mFM_R(1),'Ydata',xp(:,2)+mFM_R(2))
    set(tdhan.lh(3),'Xdata',xd(:,1),'Ydata',xd(:,2))
    set(tdhan.lh(6),'Xdata',handles.xz(:,1)+mFM_R(1),'Ydata',handles.xz(:,2)+mFM_R(2));
end
drawnow
% --------------------------------------------------------------------
function localDisplayTarget_L(mFM_L, handles, color)

tdhan=guidata(handles.tdh); % Get Target Display handles structure
if ~handles.ZoomOpt,
    xd=Circle(handles.Cursor_s,mFM_L(1:2),handles.Nmtodeg*mFM_L(3)+handles.th_zero);xd=[mFM_L(1:2);xd];
    set(tdhan.lh(1),'Xdata',handles.x(:,1)+mFM_L(1),'Ydata',handles.x(:,2)+mFM_L(2),'Color',color)
    set(tdhan.lh(2),'Xdata',handles.xp(:,1)+mFM_L(1),'Ydata',handles.xp(:,2)+mFM_L(2))
    set(tdhan.lh(3),'Xdata',xd(:,1),'Ydata',xd(:,2))
else
    x=Circle(handles.Cursor_s + mFM_L(4),mFM_L(1:2));
    xp=Circle(handles.Cursor_s + mFM_L(4),[0 0],[handles.Pie_center+handles.Nmtodeg*[-handles.Pie_size handles.Pie_size]/2 handles.th_zero]);
    xp=[0 0;xp(1,:);0 0;xp(2,:)];
    xd=Circle(handles.Cursor_s + mFM_L(4),mFM_L(1:2),handles.Nmtodeg*mFM_L(3)+handles.th_zero);xd=[mFM_L(1:2);xd];
    set(tdhan.lh(1),'Xdata',x(:,1),'Ydata',x(:,2),'Color',color)
    set(tdhan.lh(2),'Xdata',xp(:,1)+mFM_L(1),'Ydata',xp(:,2)+mFM_L(2))
    set(tdhan.lh(3),'Xdata',xd(:,1),'Ydata',xd(:,2))
    set(tdhan.lh(6),'Xdata',handles.xz(:,1)+mFM_L(1),'Ydata',handles.xz(:,2)+mFM_L(2));
end
drawnow

% --------------------------------------------------------------------
function localDisplayEnvelope_R(FM_R, handles)

%mFM=mean(FM);
mFM_R=mean(FMhand_R);

tdhan=guidata(handles.tdh); % Get Target Display handles structure
xd=Circle(handles.Cursor_s,mFM_R(1:2),handles.Nmtodeg*mFM_R(3)+handles.th_zero);xd=[mFM_R(1:2);xd];
set(tdhan.lh(1),'Xdata',handles.x(:,1)+mFM_R(1),'Ydata',handles.x(:,2)+mFM_R(2))
set(tdhan.lh(2),'Xdata',handles.xp(:,1)+mFM_R(1),'Ydata',handles.xp(:,2)+mFM_R(2))
set(tdhan.lh(3),'Xdata',xd(:,1),'Ydata',xd(:,2))
env=get(tdhan.lh(9),{'Xdata','Ydata'});    % Get the previous points
set(tdhan.lh(9),'Xdata',[env{1} FM_R(:,1)'],'Ydata',[env{2} FM_R(:,2)'])
%set(tdhan.lh(9),'Xdata',[env{1},mFM(1)],'Ydata',[env{2} mFM(2)])
drawnow
% --------------------------------------------------------------------
function localDisplayEnvelope_L(FM_L, handles)

%mFM=mean(FM);
mFM_L=mean(FMhand_L);

tdhan=guidata(handles.tdh); % Get Target Display handles structure
xd=Circle(handles.Cursor_s,mFM_L(1:2),handles.Nmtodeg*mFM_L(3)+handles.th_zero);xd=[mFM_L(1:2);xd];
set(tdhan.lh(1),'Xdata',handles.x(:,1)+mFM_L(1),'Ydata',handles.x(:,2)+mFM_L(2))
set(tdhan.lh(2),'Xdata',handles.xp(:,1)+mFM_L(1),'Ydata',handles.xp(:,2)+mFM_L(2))
set(tdhan.lh(3),'Xdata',xd(:,1),'Ydata',xd(:,2))
env=get(tdhan.lh(9),{'Xdata','Ydata'});    % Get the previous points
set(tdhan.lh(9),'Xdata',[env{1} FM_L(:,1)'],'Ydata',[env{2} FM_L(:,2)'])
%set(tdhan.lh(9),'Xdata',[env{1},mFM(1)],'Ydata',[env{2} mFM(2)])
drawnow


% ------------------------------------------------
function handles=localDisplayData(handles)
persistent data t

if ~exist([handles.filename num2str(handles.itrial-1) '.daq'],'file') & handles.itrial>1
    warndlg(['DAQ file for trial ' num2str(handles.itrial-1) ' was not saved'],'File not saved')
    save([handles.filename num2str(handles.itrial-1)],'data','t')
end

[data,t] = getdata(handles.ai);
%Beep to signal the end of the recording time so that the subject knows
%when they can relax (EDIT - APRIL 21, 2008 - Joanna Clair)
 [y,fs,bits]=wavread('beep.wav');
     wavplay(y,fs);
     
%FM=data(:,1:6);
FMhand_R = data(:,[1:6,14]); FMhand_L = data(:,[16:21,15]); %added for wrist feedback 10/30/12 LCM
% Remove the baseline forces and moments
%[m,n]=size(FM);
%FM=FM-(diag(mean(FM(1:10,:)))*ones(n,m))';  
[m,n]=size(FMhand_R);
FMhandbase_R=FMhand_R-(diag(mean(FMhand_R(1:10,:)))*ones(n,m))';
FMhandbase_L=FMhand_L-(diag(mean(FMhand_L(1:10,:)))*ones(n,m))';

% FM=JR3toFM(FM,handles);
% meanFM=meanfilt(FM,0.25*handles.SRate);
FMtorque_R=JR3toFM_L(FMhandbase_R(:,1:6),handles);
FMtorque_L=JR3toFM_L(FMhandbase_L(:,1:6),handles);
FMhand_R = [FMtorque_R FMhandbase_R(:,7)];
FMhand_L = [FMtorque_L FMhandbase_L(:,7)];
meanFM_R=meanfilt(FMhand_R,0.25*handles.SRate);
meanFM_L=meanfilt(FMhand_L,0.25*handles.SRate);
for i=1:9, %i=1:7,
    eval(['axes(handles.axes' num2str(i) ')']); 
    %cla; line(t,FM(:,i));
    cla; line(t,FMhand_R(:,i));
    %eval(['set(handles.label' num2str(i) ',''String'',num2str([max(abs(FM(:,i))) max(abs(meanFM(:,i)))],''%.3f   %.3f ''));']);
    eval(['set(handles.label' num2str(i) ',''String'',num2str([max(abs(FMhand(:,i))) max(abs(meanFM(:,i)))],''%.3f   %.3f ''));']);
end

% Check to see if more than six channels (JR3) were recorded
if size(data,2)>6
    EMG=data(:,8:13); %EMG=data(:,7:end);
    meanEMG=meanfilt(abs(EMG),0.25*handles.SRate);
    
    for i=1:size(data,2)-8 % i=1:size(data,2)-6
%         eval(['axes(handles.axes' num2str(i+7) ')']);
        eval(['axes(handles.axes' num2str(i+9) ')']);
        cla; line(t,EMG(:,i)); line(t,meanEMG(:,i),'Color','r');
        %eval(['set(handles.label' num2str(i+7) ',''String'',num2str([max(abs(EMG(:,i))) max(meanEMG(:,i))],''%.3f   %.3f ''));']);
        eval(['set(handles.label' num2str(i+9) ',''String'',num2str([max(abs(EMG(:,i))) max(meanEMG(:,i))],''%.3f   %.3f ''));']);    
    end
end
drawnow

if get(handles.EMGMaxes,'Value')
    c=handles.itrial-handles.exctrial+2;
    try rc=ddepoke(handles.excel,['r1c' num2str(c) ':r1c' num2str(c)],[handles.filename num2str(handles.itrial)]);
    catch rc=0; end
    if rc==1
        crange=['r2c' num2str(c) ':r' num2str(size(EMG,2)+1) 'c' num2str(c)];
        rc=ddepoke(handles.excel,crange,max(abs(EMG))');
    else
        set(handles.EMGMaxes,'Value',0)
    end
end
    
if any(strcmp(get(handles.Display_Target,'Checked'),{'On','on'})) & handles.Tenvelope
    tdhan=guidata(handles.tdh); % Get Target Display handles structure
    if ~handles.EnvTargets % recording envelopes
        if ~isfield(handles,'MaxEnv') | handles.ResetEnv,
            handles.MaxEnv=GetEnvelope_L(meanFM(:,[7 4]),handles.arm); % Check get evnv
            handles.ResetEnv=0;
        else
            handles.MaxEnv=max([handles.MaxEnv; GetEnvelope_L(meanFM(:,[7 4]),handles.arm)]);
        end
        [x,y]=pol2cart((1:360)*pi/180,handles.MaxEnv);
        set(tdhan.lh(10),'Xdata',x,'Ydata',y)
    else    % recording envelope targets
        % Get maximum torque and check that criteria are met: wait for experimenter input
        theta=handles.RandTarg(handles.RandTargCnt);
%         AcceptTrial=1;
        AcceptTrial=CheckTrial(meanFM(:,[7 4 5]),theta,handles.Target_t,handles.Pie_size/2,handles.arm,handles.itrial,tdhan);
        if AcceptTrial,
            handles.RandTargCnt=handles.RandTargCnt+1;
            if handles.RandTargCnt > length(handles.RandTarg)   % Finished targets
                msgbox('You have tested all the target directions. If you wish to start again go to the Target Options dialog')
            else
                theta=handles.RandTarg(handles.RandTargCnt);
                [x2,y2]=pol2cart(theta*pi/180,handles.MaxEnv(theta));
                % Cone from cursor to target
                d=norm([x2 y2]);
                if (x2==0 & y2==0), xc=zeros(4,2);
                else xc=Circle(d,[0 0],theta+[7.5 -7.5]); xc=[0 0;xc(1,:);0 0;xc(2,:)];
                end   
                xt=Circle(d*sin(7.5*pi/180),[x2 y2]);
                
                set(tdhan.lh(11),'Xdata',xt(:,1),'Ydata',xt(:,2));
                set(tdhan.lh(12),'Xdata',xc(:,1),'Ydata',xc(:,2));
            end
        end
        set(tdhan.lh(13),'Xdata',[],'Ydata',[])
    end
    set(tdhan.lh(9),'Xdata',[],'Ydata',[])
    drawnow
end

% save([handles.filename num2str(handles.itrial)],'handles')

% -----------------------------------------------
function FMshe_R=JR3toFM_R(FM_R,handles)
abd_angle_R=handles.Abd_angle_R*pi/180;  % degrees to rad
elb_angle_R=pi-handles.Elb_angle_R*pi/180;  % degrees to rad
arm_length_R=handles.Larm_R/1000;    % mm to m
fore_length_R=handles.Lfore_R/1000;  % mm to m
z_trans_R=handles.ztrans_R/1000;    % mm to m

% Translate moments to the shoulder and elbow
[FMsh_R,FMe_R]=JR3toSHandE(FM_R,abd_angle_R,elb_angle_R,arm_length_R,fore_length_R,z_trans_R,handles.arm_R,handles.sensmat_R);
FMshe_R=[FMsh_R FMe_R(:,4)];
% -----------------------------------------------
function FMshe_L=JR3toFM_L(FM_L,handles)
abd_angle_L=handles.Abd_angle_L*pi/180;  % degrees to rad
elb_angle_L=pi-handles.Elb_angle_L*pi/180;  % degrees to rad
arm_length_L=handles.Larm_L/1000;    % mm to m
fore_length_L=handles.Lfore_L/1000;  % mm to m
z_trans_L=handles.ztrans_L/1000;    % mm to m

% Translate moments to the shoulder and elbow
[FMsh_L,FMe_L]=JR3toSHandE(FM_L,abd_angle_L,elb_angle_L,arm_length_L,fore_length_L,z_trans_L,handles.arm_L,handles.sensmat_L);
FMshe_L=[FMsh_L FMe_L(:,4)];

% --------------------------------------------------------------------
function varargout = FDfilters_Callback(h, eventdata, handles, varargin)
handles.hFD=FilterSetup(handles.chnames(8:end));
guidata(h,handles)

% --------------------------------------------------------------------
function CloseDAQ(h,eventdata,handles)
% This function replaces the default CloseRequestFcn to allow deletion of the ai
% and ao objects
% This statement sets the custom closing function for the figure
% set(figure_handle,'CloseRequestFcn','CloseDAQ')

if strcmp(lower(get(handles.Display_Target,'Checked')),'on')
    Display_Target_Callback(handles.Display_Target,[],handles);
end

% Make sure ai and ao were already initialized
if isfield(handles,'ao'), delete(handles.ao); end
if isfield(handles,'ai'),
    if isvalid(handles.ai)
        if strcmp(get(handles.ai,'running'),'On'), disp('Stopping DAQ'); stop(handles.ai); end
        disp('Deleting DAQ');delete(handles.ai);
    end
end
disp('Bye')
% diary off
delete(h);

% ----------------------------------------------------------If Changing ENV
function varargout = ResetEnvelope_Callback(h, eventdata, handles, varargin)
handles.ResetEnv=1;
msgbox('Maximum envelope has been reset','Reset Envelope')
guidata(h,handles)

% --------------------------------------------------------If Changing ENV
function varargout = LoadEnvelope_Callback(h, eventdata, handles, varargin)
% Get the trials that correspond to the envelopes and compute maximum envelope
% uiwait(warndlg('You have not recorded the data for any envelopes. Please record at least one trial','Envelope Targets','modal'))            
[fname,pname] = uigetfile('*.mat','Select the maximum envelope file (*MaxEnv.mat)');
if fname~=0,
    load(fullfile(pname,fname));
    if exist('MaxEnv','var')~=1, 
        warndlg('File does not contain envelope data')
    else
        handles.MaxEnv=MaxEnv;
    end
else % Compute envelope
    handles.MaxEnv=CalcMaxEnvelope_L(handles);
end
guidata(h,handles)

% --------------------------------------------------------If Changing ENV
function varargout = SaveEnvelope_Callback(h, eventdata, handles, varargin)
initials=handles.Name([1 find(isspace(handles.Name))+1]);
[fname,pname]=uiputfile([initials 'MaxEnv.mat'],'Save the envelope (*.mat)');
MaxEnv=handles.MaxEnv;
if fname~=0, save(fullfile(pname,fname),'MaxEnv'); 
else
    warndlg('Envelope file could not be created','Save Envelope')
end


% -------------------------------------------------------
function MaxEnv_R=CalcMaxEnvelope_R(handles)
% Get the filename and trial numbers to construct the envelope
prompt={'Enter the file name:','Enter the trial numbers as a vector:'};
def={handles.filename,''};
dlgTitle='Input Envelope Data Information';
lineNo=1;
answer=inputdlg(prompt,dlgTitle,lineNo,def);
fname=answer{1};
trials=str2num(answer{2});

MaxEnv_R=[];
for i=trials
    [data,t]=daqread([fname num2str(i)]);
    [m,n]=size(data(:,1:6));
    FM_R=data(:,1:6)-(diag(mean(data(1:10,1:6)))*ones(n,m))';
    FM_R=JR3toFM_R(FM_R,handles);
    mFM_R=meanfilt(FM_R,0.25*handles.SRate);
    if isempty(MaxEnv_R), MaxEnv_R=GetEnvelope_L(mFM_R(:,[7 4]),handles.arm_R);
    else MaxEnv_R=max([MaxEnv_R; GetEnvelope_L(mFM_R(:,[7 4]),handles.arm_R)]);
    end
end
if isfield(handles,'Name'),save([handles.Name([1 find(isspace(handles.Name))+1]) 'MaxEnv'],'MaxEnv')
else save('MaxEnv','MaxEnv')
end
% -------------------------------------------------------
function MaxEnv_L=CalcMaxEnvelope_L(handles)
% Get the filename and trial numbers to construct the envelope
prompt={'Enter the file name:','Enter the trial numbers as a vector:'};
def={handles.filename,''};
dlgTitle='Input Envelope Data Information';
lineNo=1;
answer=inputdlg(prompt,dlgTitle,lineNo,def);
fname=answer{1};
trials=str2num(answer{2});

MaxEnv_L=[];
for i=trials
    [data,t]=daqread([fname num2str(i)]);
    [m,n]=size(data(:,1:6));
    FM_L=data(:,16:21)-(diag(mean(data(1:10,16:21)))*ones(n,m))';
    FM_L=JR3toFM_L(FM_L,handles);
    mFM_L=meanfilt(FM_L,0.25*handles.SRate);
    if isempty(MaxEnv_L), MaxEnv_L=GetEnvelope_L(mFM_L(:,[7 4]),handles.arm_L);
    else MaxEnv_L=max([MaxEnv_L; GetEnvelope_L(mFM_L(:,[7 4]),handles.arm_L)]);
    end
end
if isfield(handles,'Name'),save([handles.Name([1 find(isspace(handles.Name))+1]) 'MaxEnv'],'MaxEnv')
else save('MaxEnv','MaxEnv')
end


% ----------------------------------------------------------
function SEMag_R=GetEnvelope_R(Mse_R,arm_R)
% Function to get the torque envelope by fitting a spline to the data spaced every 2 degrees.
% The spline fit is then used to compute the envelope with a resolution of 1 degree.
% SEMag: Magnitude of the spline fitted envelope
% Mse: shoulder and elbow torques that define the envelope as a matrix. The first column
%      corresponds to the x-axis, the second column to the y-axis.

EMag_R=sqrt(sum(Mse_R'.^2))';
eidx=find(EMag_R > 1);    % Exclude samples close to origin
EMag_R=EMag_R(eidx);
EAng_R=atan2(Mse_R(eidx,2),Mse_R(eidx,1))*180/pi;     % pi <= EAng <= pi

uidx=find(EAng_R<0); EAng_R(uidx)=EAng_R(uidx)+360;   % 0 <= EAng <= 2*pi
th=0:2:360;
cnt=0;
for i=1:length(th)-1
    % Separate samples into bins of 2 degrees and find the largest torque within each bin
    idx_R=find(EAng_R >= th(i) & EAng_R < th(i+1));
    cnt=cnt+1;
    if ~isempty(idx_R) % more than one point in bin
        [NEMag_R(cnt),midx]=max(EMag_R(idx_R));
        NEAng_R(cnt)=EAng_R(idx_R(midx));
    else
        NEMag_R(cnt)=0;
        NEAng_R(cnt)=th(i);
    end
end
% Fit a spline to the envelope at one degree intervals
if sum(NEMag_R)>0
    SEMag_R=spline(NEAng_R,NEMag_R,1:360);
else
    SEMag_R=10*ones(1,360);
end
% If right arm, flip the envelope horizontally
if strcmp(arm_R,'right'), SEMag_R=SEMag_R([179:-1:1,360:-1:180]); end


% ----------------------------------------------------------
function SEMag_L=GetEnvelope_L(Mse_L,arm_L)
% Function to get the torque envelope by fitting a spline to the data spaced every 2 degrees.
% The spline fit is then used to compute the envelope with a resolution of 1 degree.
% SEMag: Magnitude of the spline fitted envelope
% Mse: shoulder and elbow torques that define the envelope as a matrix. The first column
%      corresponds to the x-axis, the second column to the y-axis.

EMag_L=sqrt(sum(Mse_L'.^2))';
eidx=find(EMag_L > 1);    % Exclude samples close to origin
EMag_L=EMag_L(eidx);
EAng_L=atan2(Mse_L(eidx,2),Mse_L(eidx,1))*180/pi;     % pi <= EAng <= pi

uidx=find(EAng_L<0); EAng_L(uidx)=EAng_L(uidx)+360;   % 0 <= EAng <= 2*pi
th=0:2:360;
cnt=0;
for i=1:length(th)-1
    % Separate samples into bins of 2 degrees and find the largest torque within each bin
    idx_L=find(EAng_L >= th(i) & EAng_L < th(i+1));
    cnt=cnt+1;
    if ~isempty(idx_L) % more than one point in bin
        [NEMag_L(cnt),midx]=max(EMag_L(idx_L));
        NEAng_L(cnt)=EAng_L(idx_L(midx));
    else
        NEMag_L(cnt)=0;
        NEAng_L(cnt)=th(i);
    end
end
% Fit a spline to the envelope at one degree intervals
if sum(NEMag_L)>0
    SEMag_L=spline(NEAng_L,NEMag_L,1:360);
else
    SEMag_L=10*ones(1,360);
end
% If right arm, flip the envelope horizontally
if strcmp(arm_L,'right'), SEMag_L=SEMag_L([179:-1:1,360:-1:180]); end

% ----------------------------------------------------------
function varargout = SubjectInfo_Callback(h, eventdata, handles, varargin)
dlgh=SubjInformation(handles);
dlghandles=guidata(dlgh);

switch dlghandles.action
case 'cancel'
    % no action
case 'ok'
	% Save changes to target options
    handles.Name=get(dlghandles.Name,'String');
    handles.Age=get(dlghandles.Age,'String');
    handles.Sex=dlghandles.Sex;
    handles.Protocol=get(dlghandles.Protocol,'String');
    handles.Notes=get(dlghandles.Notes,'String');
    handles.sensmod_R=dlghandles.sensmod_R; set(handles.esensmod_R,'String',handles.sensmod_R);
    handles.sensmod_L=dlghandles.sensmod_L; set(handles.esensmod_L,'String',handles.sensmod_L);
    switch handles.sensmod_R
    case '45E15A-U760-A 250L1125'
        %   Load calibration matrix: JR3Small - small load, JR3Large - large load
        %       This is not currently being used
        MaxLoad=1;
        if ~MaxLoad,
            load JR3U760Small;
            handles.sensmat_R=JR3U760Small;
        else
            load JR3U760Large;
            handles.sensmat_R=JR3U760Large;
        end
    case '45E15A-RIC-A 1000N125'
        load JR3RICLarge;
        handles.sensmat_R=JR3RICLarge;
    end
    switch handles.sensmod_L
    case '45E15A-U760-A 250L1125'
        %   Load calibration matrix: JR3Small - small load, JR3Large - large load
        %       This is not currently being used
        MaxLoad=1;
        if ~MaxLoad,
            load JR3U760Small;
            handles.sensmat_L=JR3U760Small;
        else
            load JR3U760Large;
            handles.sensmat_L=JR3U760Large;
        end
    case '45E15A-RIC-A 1000N125'
        load JR3RICLarge;
        handles.sensmat_L=JR3RICLarge;
    end
end
guidata(h,handles);
% Close Target Options dialog box
delete(dlgh);

% -----------------------------------------------------
function varargout = SetChNames_Callback(h, eventdata, handles, varargin)
dlgh=SetChName(handles);
dlghandles=guidata(dlgh);

switch dlghandles.action
case 'cancel'
    % no action
case 'ok'
	% Save changes to target options
    for i=1:length(handles.chnames)
        eval(['handles.chnames{i}=get(dlghandles.ch' num2str(i) ', ''String'');'])
        eval(['set(handles.ylabel' num2str(i) ', ''String'',handles.chnames{i})'])
    end
    handles.daqnames(1:7)={'Fx_R','Fy_R','Fz_R','Mx_R','My_R','Mz_L','WF_R'};
    handles.daqnames(15:21)={'WF_L','Fx_L','Fy_L','Fz_L','Mx_L','My_L','Mz_L',};
    handles.daqnames(8:13)=handles.chnames(7:12);
end
guidata(h,handles)
% Close Target Options dialog box
delete(dlgh)

% ------------------------------------------------------- 
function varargout = SaveSetup_Callback(h, eventdata, handles, varargin)
if isfield(handles,'Name')
    setup.subject=struct('Date',date,'Name',handles.Name,'Age',handles.Age,'Sex',handles.Sex,...
        'Protocol',handles.Protocol,'Notes',handles.Notes);
    setup.daq=struct('inchan',handles.inchan,'daqnames',{handles.daqnames},'chnames',{handles.chnames},...
        'SRate',handles.SRate,'SLength',handles.SLength,'Timer',handles.Timer);
    setup.jr3_R=struct('Abd_angle_R',handles.Abd_angle_R,'Elb_angle_R',handles.Elb_angle_R,...
        'Larm_R',handles.Larm_R,'Lfore_R',handles.Lfore_R,'ztrans_R',handles.ztrans_R,'arm_R',handles.arm_R,...
        'SensorMod_R',handles.sensmod_R,'SensorMat_R',handles.sensmat_R);
    setup.jr3_L=struct('Abd_angle_L',handles.Abd_angle_L,'Elb_angle_L',handles.Elb_angle_L,...
        'Larm_L',handles.Larm_L,'Lfore_L',handles.Lfore_L,'ztrans_L',handles.ztrans_L,'arm_L',handles.arm_L,...
        'SensorMod_L',handles.sensmod_L,'SensorMat_L',handles.sensmat_L);
    setup.target=struct('Target_x',handles.Target_x,'Target_y',handles.Target_y,...
        'Target_t',handles.Target_t,'Target_z',handles.Target_z,'Target_s',handles.Target_s,...
        'Cursor_s',handles.Cursor_s,'Pie_size',handles.Pie_size,'th_zero',handles.th_zero,...
        'RandTarget',handles.RandTarg);

    if isfield(handles,'hFD')
        filhandles=handles.hFD;
        setup.filters=struct('gain',filhandles.gain,'fclow',filhandles.fclow,...
            'fchigh',filhandles.fchigh);
    end
    initials=handles.Name([1 find(isspace(handles.Name))+1]);
    [fname,pname]=uiputfile([initials 'Setup.mat'],'Save the setup file (*.mat)');
    if fname~=0, save(fullfile(pname,fname),'setup'); 
    else
        warndlg('Setup file could not be created','Save Setup')
    end
else
    warndlg('Please fill the subject information form first','Save Setup');
end

% ----------------------------------------------------------
function varargout = LoadSetup_Callback(h, eventdata, handles, varargin)
[fname,pname] = uigetfile('*.mat','Select the setup file (*.mat)');
if fname~=0, 
    load(fullfile(pname,fname));
    if exist('setup')==1
        setnames=fieldnames(setup);
        for i=1:length(setnames)   % Don't do the same for the filter settings
            if ~strcmp(setnames{i},'filters')
                eval(['subsetnames=fieldnames(setup.' setnames{i} ');'])
                for j=1:length(subsetnames)
                    eval(['handles.' subsetnames{j} '=setup.' setnames{i} '.' subsetnames{j} ';'])
                end
            end
        end           
    end
    set(handles.eAbd_angle_R,'String',num2str(handles.Abd_angle_R));
    set(handles.eElb_angle_R,'String',num2str(handles.Elb_angle_R)); 
    set(handles.eLarm_R,'String',num2str(handles.Larm_R));
    set(handles.eLfore_R,'String',num2str(handles.Lfore_R));
    set(handles.eztrans_R,'String',num2str(handles.ztrans_R));
    switch handles.arm_R
    case 'right'
        set(handles.Right_arm_R,'Value',1); 
        set(handles.Left_arm_R,'Value',0);
    case 'left'
        set(handles.Left_arm_R,'Value',1);
        set(handles.Right_arm_R,'Value',0); 
    end
    
    set(handles.eAbd_angle_L,'String',num2str(handles.Abd_angle_L));
    set(handles.eElb_angle_L,'String',num2str(handles.Elb_angle_L)); 
    set(handles.eLarm_L,'String',num2str(handles.Larm_L));
    set(handles.eLfore_L,'String',num2str(handles.Lfore_L));
    set(handles.eztrans_L,'String',num2str(handles.ztrans_L));
    switch handles.arm_L
    case 'right'
        set(handles.Right_arm_L,'Value',1); 
        set(handles.Left_arm_L,'Value',0);
    case 'left'
        set(handles.Left_arm_L,'Value',1);
        set(handles.Right_arm_L,'Value',0); 
    end
    
    set(handles.eSRate,'String',num2str(handles.SRate));
    set(handles.eSLength,'String',num2str(handles.SLength));
    set(handles.eTimer,'String',num2str(handles.Timer));
    
    if length(handles.Target_x) > 1, handles.Tenvelope=1; end
    % Plot labels
    for i=1:length(handles.chnames)
        eval(['set(handles.ylabel' num2str(i) ', ''String'',handles.chnames{i})'])
    end
    handles.daqnames(7:end)=handles.chnames(8:end);
    handles.inchan=0:length(handles.daqnames)-1; set(handles.eChannels,'String',num2str(length(handles.inchan)));
    guidata(h,handles)
    eChannels_Callback(h, [], handles)

    if any(strcmp(get(handles.Display_Target,'Checked'),{'on','On'}))
       Display_Target_Callback(handles.Display_Target, [], handles) 
    end
end

% --------------------------------------------------------------------
function AcceptTrial=CheckTrial(M,direction,abdlevel,zeroabd,arm,trial,tdhan);
% Get maximum torque and check that criteria are met: wait for experimenter input
% 1) |Tabd| within +-10% of desired level if Tabd<>0
%    |Tabd| within +-1% of maximum abduction if Tabd=0
% 2) <Tabd within 15 degrees of specified direction (+-7.5deg)
% 3) |Tplane| within +-10% of previous trial
% M=M(find(M(:,3)<=1.1*abdlevel & M(:,3)>=0.9*abdlevel),:);
if abdlevel>0,
    lidx=find(M(:,3)<=1.1*abdlevel & M(:,3)>=0.9*abdlevel);
elseif abdlevel<0
    lidx=find(M(:,3)>=1.1*abdlevel & M(:,3)<=0.9*abdlevel);
elseif isnan(abdlevel)
    lidx=1:length(M);
else
    lidx=find(M(:,3)<=zeroabd & M(:,3)>=-zeroabd);
end
if isempty(lidx), 
    ltidx=[];
else 
    wlidx=find(diff(lidx)>1);    % within abd/add level window
    tidx=[[lidx(1);lidx(wlidx(1:end)+1)],[lidx(wlidx(1:end));lidx(end)]];
    ltidx=tidx(find(diff(tidx,1,2)>=1000*0.5),:);
end
msgtitle=['trial ' num2str(trial) ' (' num2str(abdlevel) 'Nm, ' num2str(direction) char(176) ')'];
if isempty(ltidx)   % Criterium 1) not satisfied
    AcceptTrial=0;
    uiwait(warndlg('The abd/add level was not within 10% of the desired level',msgtitle,'modal'))
else
    idx1=[];
    for i=1:size(ltidx,1)
        idx1=[idx1 ltidx(i,1):ltidx(i,2)];
    end
    M=M(idx1,:);
    if strcmp(arm,'right'), [Tang,Tmag]=cart2pol(-M(:,1),M(:,2));
    else [Tang,Tmag]=cart2pol(M(:,1),M(:,2));
    end
    if direction > 180, direction=direction-360; end
    if direction == 180, Tang=unwrap(Tang)*180/pi;idx=find(abs(Tang)<=direction+7.5 & abs(Tang)>=direction-7.5);
    else Tang=Tang*180/pi; idx=find(Tang<=direction+7.5 & Tang>=direction-7.8);
    end
    Tmag=Tmag(idx); Tang=Tang(idx);

    if isempty(Tmag) % Criterium 2) not satisfied
        AcceptTrial=0;
        uiwait(warndlg(['The torque direction was not within 15' char(176) ' of the desired direction'],msgtitle,'modal'))
    else
        % Plot a yellow dot on the screen with the maximum
        [Tmax,idx]=max(Tmag);
        [x,y]=pol2cart(Tang(idx)*pi/180,Tmax);
        set(tdhan.lh(13),'Xdata',x,'Ydata',y), drawnow
        response=questdlg(['Torque magnitude = ' num2str(Tmax,'%.2f') ' Nm. Accept trial?'],msgtitle,'Yes','No','Yes');
        if strcmp(response,'No') % Criterium 3) not satisfied
            AcceptTrial=0;
        else
            AcceptTrial=1;
        end        
    end
end

% --------------------------------------------------------------------
function varargout = EMGMaxes_Callback(h, eventdata, handles, varargin)
if get(h,'Value')
    handles.exctrial=handles.itrial;
    handles.excel=ddeinit('excel','Sheet1');
    while handles.excel==0, 
        uiwait(warndlg('Open the MS Excel Program and then click OK','Copy EMG maxes to Excel','modal'));
        handles.excel=ddeinit('excel','Sheet1');   
    end
    nEMG=length(handles.chnames)-7;
    rc=ddepoke(handles.excel,'r1c1:r1c1','EMG Ch');
    for i=1:nEMG
        rc=ddepoke(handles.excel,['r' num2str(i+1) 'c1:r' num2str(i+1) 'c1'],handles.chnames{i+7});
    end
else
    ddeterm(handles.excel);
end
guidata(h,handles)

% --------------------------------------------------------------------
function varargout = SkipTarget_Callback(h, eventdata, handles, varargin)
tdhan=guidata(handles.tdh); % Get Target Display handles structure
if rem(handles.RandTargCnt,2), handles.RandTargCnt=handles.RandTargCnt+2;
else handles.RandTargCnt=handles.RandTargCnt+1;
end
if handles.RandTargCnt > length(handles.RandTarg)   % Finished targets
    msgbox('You have tested all the target directions. If you wish to start again go to the Target Options dialog')
else
    theta=handles.RandTarg(handles.RandTargCnt);
    [x2,y2]=pol2cart(theta*pi/180,handles.MaxEnv(theta));
    % Cone from cursor to target
    d=norm([x2 y2]);
    if (x2==0 & y2==0), xc=zeros(4,2);
    else xc=Circle(d,[0 0],theta+[7.5 -7.5]); xc=[0 0;xc(1,:);0 0;xc(2,:)];
    end   
    xt=Circle(d*sin(7.5*pi/180),[x2 y2]);
    
    set(tdhan.lh(11),'Xdata',xt(:,1),'Ydata',xt(:,2));
    set(tdhan.lh(12),'Xdata',xc(:,1),'Ydata',xc(:,2));
    drawnow
    
    % Update target list in menu
    eval(['set(handles.ST' num2str((handles.RandTargCnt+1)/2 - 1) ',''Checked'',''off'')'])
    eval(['set(handles.ST' num2str((handles.RandTargCnt+1)/2) ',''Checked'',''on'')'])
end
guidata(h,handles)

% --------------------------------------------------------------------
function varargout = SelectTarget_Callback(h, eventdata, handles, varargin)
tdhan=guidata(handles.tdh); % Get Target Display handles structure
if get(h,'Parent')==handles.SelectTarget,
%     set(['handles.ST' fix(num2str(handles.RandTargCnt)/2)],'Checked','off')
    handles.RandTargCnt=find(handles.RandTarg==str2num(get(h,'Label')));
    handles.RandTargCnt=handles.RandTargCnt(1);
    set(h,'Checked','on')
    
    % Update target on feedback
    theta=handles.RandTarg(handles.RandTargCnt);
    [x2,y2]=pol2cart(theta*pi/180,handles.MaxEnv(theta));
    % Cone from cursor to target
    d=norm([x2 y2]);
    if (x2==0 & y2==0), xc=zeros(4,2);
    else xc=Circle(d,[0 0],theta+[7.5 -7.5]); xc=[0 0;xc(1,:);0 0;xc(2,:)];
    end   
    xt=Circle(d*sin(7.5*pi/180),[x2 y2]);
    
    set(tdhan.lh(11),'Xdata',xt(:,1),'Ydata',xt(:,2));
    set(tdhan.lh(12),'Xdata',xc(:,1),'Ydata',xc(:,2));
    drawnow
    guidata(h,handles)
end

% --------------------------------------------------------------------
function varargout = FreezeDisplay_Callback(h, eventdata, handles, varargin)
fdflag=get(h,'Checked');
switch fdflag
case {'Off','off'}
    set(h,'Checked','On')
    handles.BlankDisp=1;
case {'On','on'}
    set(h,'Checked','Off')
    handles.BlankDisp=0;
end
if isfield(handles,'ai')
    if strcmp(get(handles.ai,'running'),'On'), 
        stop(handles.ai)
        set(handles.ai,'Timerfcn',{@localTimerAction,handles})
        start(handles.ai); trigger(handles.ai);
    else
        set(handles.ai,'Timerfcn',{@localTimerAction,handles})
    end        
end

guidata(h,handles)


function Stim_Callback(h, eventdata, handles, varargin)
handles.stimflag=get(h,'Value');
if handles.stimflag
    set(handles.text78,'String','Stim Amplitude (mA)')
    set(handles.text79,'Visible','Off')
    handles.PulseStop=0; set(handles.ePulseStop,'Visible','Off')
else
    set(handles.text78,'String','Pulse start time (s)')
    handles.PulseStart=0; set(handles.ePulseStart,'String',num2str(handles.PulseStart))
    set(handles.text79,'Visible','On')
    set(handles.ePulseStop,'Visible','On'); set(handles.ePulseStart,'String',num2str(handles.PulseStop))
end
if isfield(handles,'ai')
    if strcmp(get(handles.ai,'running'),'On'), 
        stop(handles.ai)
        set(handles.ai,'Timerfcn',{@localTimerAction,handles})
        start(handles.ai); trigger(handles.ai);
    else
        set(handles.ai,'Timerfcn',{@localTimerAction,handles})
    end        
end

guidata(h,handles)

function KeyPress_Callback(h, eventdata, handles, varargin)

if lower(get(h,'CurrentCharacter'))=='a', Acquire_Callback(h,[],guidata(h)); end


% --- Executes when figure1 window is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

