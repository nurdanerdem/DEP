%**************************************************************************

%This code is generated in MATLAB (R2016a) for plotting the DEP (Dielectrophoretic)
%response of the cells by using single shell model 

%**************************************************************************

%DEP_Response_2.m  version 2.0 : Takes DEP parameters as input for two cells 
%%Make sure DEP_Response_2.fig file present in the same directory
%Relased Date: June, 2017 
%Author: Nurdan Erdem, Sabanci University, Faculty of Engineering and
%Natural Sciences

%Please refer to the article for more information: Erdem, N., Yýldýzhan, Y., Elitaþ, M., 2017. 
% "A numerical approach for dielectrophoretic characterization and separation of human hematopoietic cells"
% International Journal of Engineering Research & Technology (IJERT) 6, 1079-1082.

%**************************************************************************


function varargout = DEP_Response_2(varargin)

% DEP_RESPONSE_2 MATLAB code for DEP_Response_2.fig
%      DEP_RESPONSE_2, by itself, creates a new DEP_RESPONSE_2 or raises the existing
%      singleton*.
%
%      H = DEP_RESPONSE_2 returns the handle to a new DEP_RESPONSE_2 or the handle to
%      the existing singleton*.
%
%      DEP_RESPONSE_2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEP_RESPONSE_2.M with the given input arguments.
%
%      DEP_RESPONSE_2('Property','Value',...) creates a new DEP_RESPONSE_2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DEP_Response_2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DEP_Response_2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DEP_Response_2

% Last Modified by GUIDE v2.5 21-Jun-2017 06:17:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DEP_Response_2_OpeningFcn, ...
                   'gui_OutputFcn',  @DEP_Response_2_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before DEP_Response_2 is made visible.
function DEP_Response_2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DEP_Response_2 (see VARARGIN)

% Choose default command line output for DEP_Response_2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DEP_Response_2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DEP_Response_2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%*********************************************************************
%     MAIN PART OF THE CODE
%*********************************************************************


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%**************************************************************************
%                    Parameters for Single Shell Cell Model
%**************************************************************************
%For example parameters see parameters.txt and enter them after you run the
%this code


%permittivity of the empty space
e0 = 8.85e-12; 

%r:radius of the cell
%multiplied by 1e-6 for making micrometer input as meter in unit
r=[str2num(get(handles.radius1,'String'))*(1e-6) str2num(get(handles.radius2,'String'))*(1e-6)];

%d: thickness of the cell membrane
%multiplied by 1e-9 for making nanometer input as meter in unit
d=[str2num(get(handles.thickness1,'String'))*(1e-9) str2num(get(handles.thickness2,'String'))*(1e-9)];


%c_med: conductivity of the suspending medium
c_med=[str2num(get(handles.cmed1,'String')) str2num(get(handles.cmed2,'String'))];
 
%Emed: permittivity of the suspending medium
E_med=[e0*str2num(get(handles.Emed1,'String')) e0*str2num(get(handles.Emed2,'String'))];


%c_mem: conductivity of the cell membrane (ie. outer cell conductivity)
c_mem=[str2num(get(handles.cmem1,'String')) str2num(get(handles.cmem2,'String'))];


%Emem: permittivity of the cell membrane (ie. outer cell permittivity)
E_mem=[e0*str2num(get(handles.Emem1,'String')) e0*str2num(get(handles.Emem2,'String'))];


%c_cyto: conductivity of the cytoplasm (ie. inner cell conductivity)
c_cyto=[str2num(get(handles.ccyto1,'String')) str2num(get(handles.ccyto2,'String'))];


%Ecyto: permittivity of the cytoplasm (ie. inner cell permittivity)
E_cyto=[e0*str2num(get(handles.Ecyto1,'String')) e0*str2num(get(handles.Ecyto2,'String'))];

%phi: cell membrane folding factor 
phi=[str2num(get(handles.ff1,'String')) str2num(get(handles.ff2,'String'))];


%**************************************************************************

f = logspace(0,7,1000); %generate frequencies between 1 Hz and 10 MHz
%logspace generates list of numbers in log space, first num in paranthesisi
%indicate the order of ten the list starts, second one :order of ten where the list
%stops, last one: number of points in the list

w = 2*pi*f; %generate corresponding angular frequencies
j = sqrt(-1); %imaginary number j


%create empty matrices to be filled in the for loop
cEmed=zeros(2,1000);
cEcyto=zeros(2,1000);
cEmem=zeros(2,1000);
r_in=zeros(2,1);
r_out=zeros(2,1);
Eeff=zeros(2,1000);
CM=zeros(2,1000);
output=zeros(2,1000);
p=zeros(2);

axes(handles.axes2);
 for i=1:2
%calculation of complex permittivities to be used in CM factor
cEmed(i,:) = E_med(i)-(j*c_med(i))./w;    %medium complex permittivity
cEcyto(i,:)= E_cyto(i)- (j*c_cyto(i))./w; %cytoplasm complex permittivity
cEmem(i,:)= E_mem(i)-(j*c_mem(i))./w;     %membrane complex permittivity    

%inner and outer radii calculation-folding factor affects the radius of the
%cells
r_in(i)=r(i).*phi(i)-d(i);
r_out(i)=r(i).*phi(i);


%effective complex permittivity 
Eeff(i,:)= cEmem(i,:).*((r_out(i)./r_in(i)).^3+(2.*(cEcyto(i,:)-cEmem(i,:))./(cEcyto(i,:)+2.*cEmem(i,:))))./((r_out(i)./r_in(i)).^3-((cEcyto(i,:)-cEmem(i,:))./(cEcyto(i,:)+2.*cEmem(i,:)))); % effective complex permittivity of the system when single shell model is used 


%CM factor 
CM(i,:)=(Eeff(i,:)-cEmed(i,:))./(Eeff(i,:)+2*cEmed(i,:));


%real part of the CM factor 
output(i,:)=real(CM(i,:));

%plots
p(i)=semilogx(f,output(i,:),'-.'); %logaritmic in the x-axis
hold on
 end
%plot y=0 line for clearly observing the crossover frequencies
fun1 = @(x) (0); 
fplot(fun1, [10^0,10^7],'r');
ax = gca;
ax.XMinorGrid= 'on';
ylim([-0.8 1]); %Real part of the CM factor can only be between 1 and -0.5
xlabel('Frequency (Hz)');
ylabel('Re[CM-factor]');

%crossover frequency where CM factor is zero
crossover1=0.001*interp1(output(1, :),f, 0); 
crossover2=0.001*interp1(output(2, :),f, 0); 

%display the crossover frequencies 
set(handles.crossov1,'String',crossover1);
set(handles.crossov2,'String',crossover2);



function crossov1_Callback(hObject, eventdata, handles)
% hObject    handle to crossov1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of crossov1 as text
%        str2double(get(hObject,'String')) returns contents of crossov1 as a double


% --- Executes during object creation, after setting all properties.
function crossov1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to crossov1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function crossov2_Callback(hObject, eventdata, handles)
% hObject    handle to crossov2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of crossov2 as text
%        str2double(get(hObject,'String')) returns contents of crossov2 as a double


% --- Executes during object creation, after setting all properties.
function crossov2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to crossov2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function radius2_Callback(hObject, eventdata, handles)
% hObject    handle to radius2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of radius2 as text
%        str2double(get(hObject,'String')) returns contents of radius2 as a double


% --- Executes during object creation, after setting all properties.
function radius2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radius2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function thickness2_Callback(hObject, eventdata, handles)
% hObject    handle to thickness2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thickness2 as text
%        str2double(get(hObject,'String')) returns contents of thickness2 as a double


% --- Executes during object creation, after setting all properties.
function thickness2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thickness2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cmed2_Callback(hObject, eventdata, handles)
% hObject    handle to cmed2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cmed2 as text
%        str2double(get(hObject,'String')) returns contents of cmed2 as a double


% --- Executes during object creation, after setting all properties.
function cmed2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cmed2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Emed2_Callback(hObject, eventdata, handles)
% hObject    handle to Emed2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Emed2 as text
%        str2double(get(hObject,'String')) returns contents of Emed2 as a double


% --- Executes during object creation, after setting all properties.
function Emed2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Emed2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cmem2_Callback(hObject, eventdata, handles)
% hObject    handle to cmem2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cmem2 as text
%        str2double(get(hObject,'String')) returns contents of cmem2 as a double


% --- Executes during object creation, after setting all properties.
function cmem2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cmem2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Emem2_Callback(hObject, eventdata, handles)
% hObject    handle to Emem2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Emem2 as text
%        str2double(get(hObject,'String')) returns contents of Emem2 as a double


% --- Executes during object creation, after setting all properties.
function Emem2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Emem2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ccyto2_Callback(hObject, eventdata, handles)
% hObject    handle to ccyto2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ccyto2 as text
%        str2double(get(hObject,'String')) returns contents of ccyto2 as a double


% --- Executes during object creation, after setting all properties.
function ccyto2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ccyto2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ecyto2_Callback(hObject, eventdata, handles)
% hObject    handle to Ecyto2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ecyto2 as text
%        str2double(get(hObject,'String')) returns contents of Ecyto2 as a double


% --- Executes during object creation, after setting all properties.
function Ecyto2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ecyto2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ff2_Callback(hObject, eventdata, handles)
% hObject    handle to ff2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ff2 as text
%        str2double(get(hObject,'String')) returns contents of ff2 as a double


% --- Executes during object creation, after setting all properties.
function ff2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ff2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function radius1_Callback(hObject, eventdata, handles)
% hObject    handle to radius1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of radius1 as text
%        str2double(get(hObject,'String')) returns contents of radius1 as a double


% --- Executes during object creation, after setting all properties.
function radius1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radius1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function thickness1_Callback(hObject, eventdata, handles)
% hObject    handle to thickness1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thickness1 as text
%        str2double(get(hObject,'String')) returns contents of thickness1 as a double


% --- Executes during object creation, after setting all properties.
function thickness1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thickness1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cmed1_Callback(hObject, eventdata, handles)
% hObject    handle to cmed1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cmed1 as text
%        str2double(get(hObject,'String')) returns contents of cmed1 as a double


% --- Executes during object creation, after setting all properties.
function cmed1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cmed1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Emed1_Callback(hObject, eventdata, handles)
% hObject    handle to Emed1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Emed1 as text
%        str2double(get(hObject,'String')) returns contents of Emed1 as a double


% --- Executes during object creation, after setting all properties.
function Emed1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Emed1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cmem1_Callback(hObject, eventdata, handles)
% hObject    handle to cmem1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cmem1 as text
%        str2double(get(hObject,'String')) returns contents of cmem1 as a double


% --- Executes during object creation, after setting all properties.
function cmem1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cmem1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Emem1_Callback(hObject, eventdata, handles)
% hObject    handle to Emem1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Emem1 as text
%        str2double(get(hObject,'String')) returns contents of Emem1 as a double


% --- Executes during object creation, after setting all properties.
function Emem1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Emem1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ccyto1_Callback(hObject, eventdata, handles)
% hObject    handle to ccyto1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ccyto1 as text
%        str2double(get(hObject,'String')) returns contents of ccyto1 as a double


% --- Executes during object creation, after setting all properties.
function ccyto1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ccyto1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ecyto1_Callback(hObject, eventdata, handles)
% hObject    handle to Ecyto1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ecyto1 as text
%        str2double(get(hObject,'String')) returns contents of Ecyto1 as a double


% --- Executes during object creation, after setting all properties.
function Ecyto1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ecyto1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ff1_Callback(hObject, eventdata, handles)
% hObject    handle to ff1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ff1 as text
%        str2double(get(hObject,'String')) returns contents of ff1 as a double


% --- Executes during object creation, after setting all properties.
function ff1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ff1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
