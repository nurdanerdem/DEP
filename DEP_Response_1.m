


%**************************************************************************

%This code generated in MATLAB (R2016a) for plotting the DEP (Dielectrophoretic)
%response of the cells by using single shell model 

%**************************************************************************

%DEP_Response_1.m  version 1.0 
%Make sure DEP_Response_1.fig file present in the same directory
%Takes DEP parameter inputs for only one cell
%Relased Date: June, 2017 
%Author: Nurdan Erdem, Sabanci University, Faculty of Engineering and
%Natural Sciences

%Please refer to the article for more information: Erdem, N., Yýldýzhan, Y., Elitaþ, M., 2017. 
% "A numerical approach for dielectrophoretic characterization and separation of human hematopoietic cells"
% International Journal of Engineering Research & Technology (IJERT) 6, 1079-1082.

%**************************************************************************



function varargout = DEP_Response_1(varargin)
% DEP_Response_1 MATLAB code for DEP_Response_1.fig
%      DEP_Response_1, by itself, creates a new DEP_Response_1 or raises the existing
%      singleton*.
%
%      H = DEP_Response_1 returns the handle to a new DEP_Response_1 or the handle to
%      the existing singleton*.
%
%      DEP_Response_1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEP_Response_1.M with the given input arguments.
%
%     DEP_Response_1('Property','Value',...) creates a new DEP_Response_1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DEP_Response_1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DEP_Response_1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DEP_Response_1

% Last Modified by GUIDE v2.5 12-Jun-2017 02:46:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DEP_Response_1_OpeningFcn, ...
                   'gui_OutputFcn',  @DEP_Response_1_OutputFcn, ...
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


% --- Executes just before DEP_Response_1 is made visible.
function DEP_Response_1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DEP_Response_1 (see VARARGIN)

% Choose default command line output for DEP_Response_1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DEP_Response_1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DEP_Response_1_OutputFcn(hObject, eventdata, handles) 
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
function pushbutton1_Callback(~, eventdata, handles)
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
r=str2num(get(handles.radius,'String'))*(1e-6);

%d: thickness of the cell membrane
%multiplied by 1e-9 for making nanometer input as meter in unit
d=str2num(get(handles.thickness,'String'))*(1e-9);

%c_med: conductivity of the suspending medium
c_med=str2num(get(handles.cmed,'String'));

%Emed: permittivity of the suspending medium
Emed=e0*str2num(get(handles.E_med,'String'));

%c_mem: conductivity of the cell membrane (ie. outer cell conductivity)
c_mem=str2num(get(handles.cmem,'String'));

%Emem: permittivity of the cell membrane (ie. outer cell permittivity)
Emem=e0*str2num(get(handles.E_mem,'String'));

%c_cyto: conductivity of the cytoplasm (ie. inner cell conductivity)
c_cyto=str2num(get(handles.ccyto,'String'));

%Ecyto: permittivity of the cytoplasm (ie. inner cell permittivity)
Ecyto=e0*str2num(get(handles.E_cyto,'String'));

%phi: cell membrane folding factor 
phi=str2num(get(handles.ff,'String'));

%**************************************************************************

f = logspace(0,7,1000); %generate frequencies between 1 Hz and 10 MHz
%logspace generates list of numbers in log space, first num in paranthesisi
%indicate the order of ten the list starts, second one :order of ten where the list
%stops, last one: number of points in the list

w = 2*pi*f; %generate corresponding angular frequencies
j = sqrt(-1); %imaginary number j

%complex permittivities to be used in Clausius-Mossotti (CM) factor
cEmed= Emed-(j*c_med)./w; %medium complex permittivity
cEcyto= Ecyto- (j*c_cyto)./w; %cytoplasm complex permittivity
cEmem= Emem-(j*c_mem)./w; %membrane complex permittivity
%inner and outer radius calculation
r_in=r*phi-d;
r_out=r*phi;
%effective complex permittivity
Eeff= cEmem.*((r_out/r_in)^3+(2.*(cEcyto-cEmem)./(cEcyto+2.*cEmem)))./((r_out/r_in)^3-((cEcyto-cEmem)./(cEcyto+2.*cEmem))); % effective complex permittivity of the system when single shell model is used 

%CM factor 
CM=(Eeff-cEmed)./(Eeff+2*cEmed);
%real part of the CM factor
output=real(CM);

axes(handles.axes1);
semilogx(f,output); %logaritmic in the x-axis
hold on

%plot y=0 line for clearly observing the crossover frequencies
fun1 = @(x) (0); 
fplot(fun1, [10^0,10^7],'r');

ylim([-0.8 1]); %Real part of the CM factor can only be between 1 and -0.5
xlabel('Frequency (Hz)');
ylabel('Re[CM-factor]');

%crossover frequency where CM factor is zero
crossover=0.001*interp1(output,f, 0); 
%display the first crossover frequency 
set(handles.fcm,'String',crossover);


function radius_Callback(hObject, eventdata, handles)
% hObject    handle to radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of radius as text
%        str2double(get(hObject,'String')) returns contents of radius as a double


% --- Executes during object creation, after setting all properties.
function radius_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function E_med_Callback(hObject, eventdata, handles)
% hObject    handle to E_med (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of E_med as text
%        str2double(get(hObject,'String')) returns contents of E_med as a double


% --- Executes during object creation, after setting all properties.
function E_med_CreateFcn(hObject, eventdata, handles)
% hObject    handle to E_med (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ff_Callback(hObject, eventdata, handles)
% hObject    handle to ff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ff as text
%        str2double(get(hObject,'String')) returns contents of ff as a double


% --- Executes during object creation, after setting all properties.
function ff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function E_cyto_Callback(hObject, eventdata, handles)
% hObject    handle to E_cyto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of E_cyto as text
%        str2double(get(hObject,'String')) returns contents of E_cyto as a double


% --- Executes during object creation, after setting all properties.
function E_cyto_CreateFcn(hObject, eventdata, handles)
% hObject    handle to E_cyto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cmed_Callback(hObject, eventdata, handles)
% hObject    handle to cmed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cmed as text
%        str2double(get(hObject,'String')) returns contents of cmed as a double


% --- Executes during object creation, after setting all properties.
function cmed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cmed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ccyto_Callback(hObject, eventdata, handles)
% hObject    handle to ccyto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ccyto as text
%        str2double(get(hObject,'String')) returns contents of ccyto as a double


% --- Executes during object creation, after setting all properties.
function ccyto_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ccyto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cmem_Callback(hObject, eventdata, handles)
% hObject    handle to cmem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cmem as text
%        str2double(get(hObject,'String')) returns contents of cmem as a double


% --- Executes during object creation, after setting all properties.
function cmem_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cmem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function thickness_Callback(hObject, eventdata, handles)
% hObject    handle to thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thickness as text
%        str2double(get(hObject,'String')) returns contents of thickness as a double


% --- Executes during object creation, after setting all properties.
function thickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function E_mem_Callback(hObject, eventdata, handles)
% hObject    handle to E_mem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of E_mem as text
%        str2double(get(hObject,'String')) returns contents of E_mem as a double


% --- Executes during object creation, after setting all properties.
function E_mem_CreateFcn(hObject, eventdata, handles)
% hObject    handle to E_mem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
