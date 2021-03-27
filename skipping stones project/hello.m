function varargout = hello(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @hello_OpeningFcn, ...
                   'gui_OutputFcn',  @hello_OutputFcn, ...
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

end
% --- Executes just before hello is made visible.
function hello_OpeningFcn(hObject, eventdata, handles, varargin)


% Choose default command line output for hello
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
set(gca,'Xlim',[0 25],'Ylim',[0 25],'Zlim',[-0.2 1])
view(-7,28);
hold on
p1 = [0 0 0];
p2 = [25 0 0];
p3 = [25 25 0];
p4 = [0 25 0]; 

xc = [p1(1) p2(1) p3(1) p4(1)];
yc = [p1(2) p2(2) p3(2) p4(2)];
zc = [p1(3) p2(3) p3(3) p4(3)];

% fill3(xc, yc, zc, 2);

patch(xc,yc,zc,'blue')
hold on
 global Ekin;
 global Epot;
%   wasser=bwat;
   Ekin=[];
    Epot=[];
end
function varargout = hello_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

end
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xo 
xo=str2double(get(handles.text,'String'));
 assignin('base','xo',xo);
global ho
ho=str2double(get(handles.edit2,'String'));
 assignin('base','ho',ho);
 global vxo
vxo=str2double(get(handles.edit3,'String'));
 assignin('base','vxo',vxo);
 global vzo
vzo=str2double(get(handles.edit4,'String'));
 assignin('base','vzo',vzo);
  global teta
teta=str2double(get(handles.edit6,'String'));
 assignin('base','teta',teta);
 global SimNb
SimNb=str2double(get(handles.edit7,'String'));
 assignin('base','SimNb',SimNb);
  global mass
mass=str2double(get(handles.masskg,'String'));
 assignin('base','mass',mass);
 drawpath = get(handles.path, 'Value');
 nmax=round((vxo^2/(4*pi*9.8*1.23))*sqrt((1.005*1000*0.025)/(2*0.1*sin(teta))))
  assignin('base','nmax',nmax);
% set(handles.edit2,'String',N);
global x z ;
[t,x,z]=RK4(@funx,@funz,xo,vxo,ho,vzo,0,100,SimNb,teta,mass);
curve=animatedline('linewidth',1,'LineStyle','--');
set(gca,'Xlim',[0 25],'Ylim',[0 25],'Zlim',[-0.2 1])
view(-7,28);


p1 = [0 0 0];
p2 = [25 0 0];
p3 = [25 25 0];
p4 = [0 25 0]; 

xc = [p1(1) p2(1) p3(1) p4(1)];
yc = [p1(2) p2(2) p3(2) p4(2)];
zc = [p1(3) p2(3) p3(3) p4(3)];

% fill3(xc, yc, zc, 2);


patch(xc,yc,zc,'blue')
hold on
rotate3d on
  counter=0;
 j=1;
 nbskip=0;

for i=1:length(x)
 
  
     y(i)=10*t(i);
    if(drawpath)
    
    addpoints(curve,x(i),y(i),z(i));
    end
    head=scatter3(x(i),y(i),z(i),'filled','markerfacecolor','k','markeredgecolor','k','linewidth',7+5*mass);
    drawnow();
    pause(0.001);
    delete(head);
    hold on
   
    if(z(i)<=0 || counter>=1)
     if(nbskip<nmax&&z(i)>-4)
       if(counter==0)
           start= 'true';
           oldx=x(i);
           oldy=y(i);
%            view(40,70)
%            headc=scatter(oldx,oldy,90,'o','markeredgecolor',[0 .75 .75],'linewidth',1);
         circ1=plotCircle3D([oldx,oldy,0],[0,0,1],j);
          pause(0.001)
          drawnow();
         counter=counter+1;
         j=j+0.2;
         continue
       end
     
           if(counter<5)
                
           view(40,70)
%            headc=scatter(oldx,oldy,6*j+200,'o','markeredgecolor',[0 .75 .75],'linewidth',1);
                  if(counter>=2)
                      delete(circ2)
                  end
                  circ2=plotCircle3D([oldx,oldy,0],[0,0,1],j);
                  drawnow();
                  pause(0.001)
                  counter=counter+1;
                  if(nbskip<=2)
                  j=j+0.5;
                  else
                      j=j+0.2;
                  end
                   delete(circ1)
                  continue
           end
      
                     if(counter==5)
                         counter=0;
                          j=1;
                         delete(circ2)
                         
                     end
                     nbskip=nbskip+1;
     end
        
% hold on
  
     end
end
hold off

% --- Executes during object creation, after setting all properties.
end
function pushbutton1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

end

function text_Callback(hObject, eventdata, handles)
% hObject    handle to text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of text as text
%        str2double(get(hObject,'String')) returns contents of text as a double


% --- Executes during object creation, after setting all properties.
end
function text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


end
function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
end
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double

end
% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end

function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double

end
% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end

function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double

end
% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double
end

% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end



% --- Executes on button press in run.


% --- Executes on button press in clear.
function clear_Callback(hObject, eventdata, handles)
set(handles.edit2, 'String', '');
set(handles.edit3, 'String', '');
set(handles.edit4, 'String', '');
set(handles.edit6, 'String', '');
set(handles.text, 'String', '');
set(handles.masskg, 'String', '');
set(handles.edit7, 'String', '');
set(handles.path, 'Value', 0);
cla
view(-7,28);
hold on
p1 = [0 0 0];
p2 = [25 0 0];
p3 = [25 25 0];
p4 = [0 25 0]; 

xc = [p1(1) p2(1) p3(1) p4(1)];
yc = [p1(2) p2(2) p3(2) p4(2)];
zc = [p1(3) p2(3) p3(3) p4(3)];

% fill3(xc, yc, zc, 2);
patch(xc,yc,zc,'blue')
hold on
end


% --- Executes on button press in path.
function path_Callback(hObject, eventdata, handles)
% hObject    handle to path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of path
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double

end
% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end

function masskg_Callback(hObject, eventdata, handles)
% hObject    handle to masskg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of masskg as text
%        str2double(get(hObject,'String')) returns contents of masskg as a double
end

% --- Executes during object creation, after setting all properties.
function masskg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to masskg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


% --- Executes on button press in virtualreality.
function virtualreality_Callback(hObject, eventdata, handles)
% hObject    handle to virtualreality (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xo 
xo=str2double(get(handles.text,'String'));
 assignin('base','xo',xo);
global ho
ho=str2double(get(handles.edit2,'String'));
 assignin('base','ho',ho);
 global vxo
vxo=str2double(get(handles.edit3,'String'));
 assignin('base','vxo',vxo);
 global vzo
vzo=str2double(get(handles.edit4,'String'));
 assignin('base','vzo',vzo);
  global teta
teta=str2double(get(handles.edit6,'String'));
 assignin('base','teta',teta);
 global SimNb
SimNb=str2double(get(handles.edit7,'String'));
 assignin('base','SimNb',SimNb);
  global mass
mass=str2double(get(handles.masskg,'String'));
 assignin('base','mass',mass);
 
 nmax=round((vxo^2/(4*pi*9.8*1.23))*sqrt((1.005*1000*0.025)/(2*0.1*sin(teta))))
  assignin('base','nmax',nmax);
% set(handles.edit2,'String',N);
[t,x,z]=RK4(@funx,@funz,xo,vxo,ho,vzo,0,100,SimNb,teta,mass);






myworld = vrworld('skippingstonevr.wrl');
open(myworld);
set(myworld, 'Description', 'Skipping Stone');
view(myworld);


% pause(1);

for i=1:length(x)
    y(i)=-5.81;
end

for i=1:length(x)
myworld.stone.translation = [x(i)*2-10.42 z(i)*3 y(i)];

pause(0.03)
end

end


% --- Executes during object creation, after setting all properties.


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
global xo 
xo=str2double(get(handles.text,'String'));
 assignin('base','xo',xo);
global ho
ho=str2double(get(handles.edit2,'String'));
 assignin('base','ho',ho);
 global vxo
vxo=str2double(get(handles.edit3,'String'));
 assignin('base','vxo',vxo);
 global vzo
vzo=str2double(get(handles.edit4,'String'));
 assignin('base','vzo',vzo);
  global teta
teta=str2double(get(handles.edit6,'String'));
 assignin('base','teta',teta);
 global SimNb
SimNb=str2double(get(handles.edit7,'String'));
 assignin('base','SimNb',SimNb);
  global mass
mass=str2double(get(handles.masskg,'String'));
 assignin('base','mass',mass);
 
 nmax=round((vxo^2/(4*pi*9.8*1.23))*sqrt((1.005*1000*0.025)/(2*0.1*sin(teta))))
  assignin('base','nmax',nmax);
% set(handles.edit2,'String',N);
[t,x,z]=RK4(@funx,@funz,xo,vxo,ho,vzo,0,100,SimNb,teta,mass);
%  set(gca,'Xlim',[0 25],'Zlim',[-0.1 1])

figure()
plot(x,z);
 xlim([0 25]);
end


% --- Executes on mouse press over figure background.
function figure1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end
