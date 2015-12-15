function varargout = RayTracer(varargin)
% RAYTRACER MATLAB code for RayTracer.fig
%      RAYTRACER, by itself, creates a new RAYTRACER or raises the existing
%      singleton*.
%
%      H = RAYTRACER returns the handle to a new RAYTRACER or the handle to
%      the existing singleton*.
%
%      RAYTRACER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RAYTRACER.M with the given input arguments.
%
%      RAYTRACER('Property','Value',...) creates a new RAYTRACER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RayTracer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RayTracer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RayTracer

% Last Modified by GUIDE v2.5 07-Dec-2015 11:47:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RayTracer_OpeningFcn, ...
                   'gui_OutputFcn',  @RayTracer_OutputFcn, ...
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


% --- Executes just before RayTracer is made visible.
function RayTracer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RayTracer (see VARARGIN)

% Choose default command line output for RayTracer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes RayTracer wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%plot a defualt line
redraw(handles);
ini_mirrorArray();
global mirrorCounter;
mirrorCounter = 1;

% --- Outputs from this function are returned to the command line.
function varargout = RayTracer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function xValue_Callback(hObject, eventdata, handles)
% hObject    handle to xValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xValue as text
%        str2double(get(hObject,'String')) returns contents of xValue as a double
redraw(handles);

% --- Executes during object creation, after setting all properties.
function xValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yValue_Callback(hObject, eventdata, handles)
% hObject    handle to yValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yValue as text
%        str2double(get(hObject,'String')) returns contents of yValue as a double
redraw(handles);

% --- Executes during object creation, after setting all properties.
function yValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function rayangle_Callback(hObject, eventdata, handles)
% hObject    handle to rayangle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function rayangle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rayangle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function angleSlider_Callback(hObject, eventdata, handles)
% hObject    handle to angleSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
slider = hObject;
value = get(slider,'value');
handles.angleValue.String = value;
redraw(handles);

% --- Executes during object creation, after setting all properties.
function angleSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to angleSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%returns a vector with 2 x and y points
function [x, y] = basedOnAngle(x1, y1, angle)
x(1) = x1;
y(1) = y1;
x(2) = x1(1) + 20 * cosd(angle);
y(2) = y1(1) + 20 * sind(angle);

%works out the length of a line based on 2 points
function length = lengthOfLine(x, y)
length = sum(sqrt(diff(x).^2+diff(y).^2));


%custom function to plot the point on slide update
%this function will plot a line between 2 points based on that angle
%It also checks for mirror collision and will plot recursively if mirrors
function plotPoint(handles)
hold on
xvalue = str2num(handles.xValue.String);
yvalue = str2num(handles.yValue.String);
global mirrorCounter;
if(xvalue >= 0 & yvalue >= 0)
    cla
    plotted = false;
    angle = str2num(handles.angleValue.String);
    [x1, y1] = basedOnAngle(xvalue, yvalue, angle);
    global currentmirror
    currentmirror = 0;
    [newx, newy, hit, cmid, mirrorx, mirrory] = findClosestMirror(x1, y1);
    lastx = newx;
    lasty = newy;
    global hitcounter;
    hitcounter = 0;
        if (hit == true) && (1 == 1)
            display('hit')
            if hitcounter == 0
                hitcounter = hitcounter + 1
                [reflectionx, reflectiony] = getReflectionCord(newx, newy, cmid, mirrorx, mirrory);
                %plot the initial beam
                plot(lastx, lasty, '-r');
                %check to see if the reflection hits somewhere
                [newx, newy, hit, cmid, mirrorx, mirrory ] = findClosestMirror(reflectionx, reflectiony);
                
                if hit == true
                    
                    display('boom')
                    [reflectionx, reflectiony] = getReflectionCord(newx, newy, cmid, mirrorx, mirrory);
                    plot([newx(1), reflectionx(1)], [newy(1), reflectiony(1)], '-r');
                    plot([newx(2), reflectionx(2)], [newy(2), reflectiony(2)], '-r');
                else
                    display('nah')
                    plot(reflectionx, reflectiony, '-r');
                end

                
            else
           
            end  
   
    
        else
            if hit == true
             %[newx, newy, hit, cmid, mirrorx, mirrory, ] = findClosestMirror(x1, y1, currentmirror);
             [reflectionx, reflectiony] = getReflectionCord(newx, newy, cmid, mirrorx, mirrory);
              plot(reflectionx, reflectiony, '-r');
            end
             %plot the initial beam
             plot(lastx, lasty, '-r');
        end
    axis([0 12 0 12]);
    hold off  
end

function [reflectionx, reflectiony] = getReflectionCord(newx, newy, cmid, mirrorx, mirrory)
interceptx = newx(2);
intercepty = newy(2);

xm =  mirrorx(2) - mirrorx(1);
ym = mirrory(2) - mirrory(1);

normal = [ym, (-1*xm)]

n = normal/norm(normal)
%plots the normal
%plot([interceptx, normal(1)+interceptx], [intercepty, (normal(2)+intercepty)])
d(1) = newx(2) - newx(1);
d(2) = newy(2) - newy(1);
d = d/norm(d);
r = d - ((2 * (dot(d,n))) * n);

reflectionx = [interceptx, 10 * r(1) + interceptx];
reflectiony = [intercepty, 10* r(2) + intercepty];

function angle = angleOfMirror(mirrorId)
[xm, ym] = getMirrorValues(mirrorId);
%v.w = ||v||.||w|| cos(pheta)
[xm, ym] = checkVector(xm, ym);
vw = ((xm(2)-xm(1))*(7-5)) + ((ym(2)-ym(1))*(0-0));
modV= sqrt((xm(2)-xm(1))^2 + (ym(2)-ym(1))^2);
modW=sqrt((7-5)^2 + (0-0)^2);
angle = acosd( vw/(modV*modW));

function [x, y] = checkVector(x, y)
if y(2) > y(1)
    yt(1) = y(2);
    yt(2) = y(1);
    xt(1) = x(2);
    xt(2) = x(1);
    x = xt;
    y = yt;
end

    

function [newx, newy, hit, cmid, mirrorx, mirrory] = findClosestMirror(x1, y1)
global mirrorCounter;
global currentmirror;

mirrorx = [];
mirrory = [];
hit = false;
if mirrorCounter > 1
        am = get_mirrorArray;
        clear cmx
        cmx = [];
        cmy = [];
        cmd = 0;
        cmid = 0;
        anglenew = 0;
        mirrorStartEnd = [];
            for idx = 1:numel(am)
                [x2, y2] = getMirrorValues(idx);
                [xi, yi] = findIntercept(x1, y1, x2, y2, idx);
               if not(isempty(xi))
                dx(1) = xi;
                dx(2) = x1(1);
                dy(1) = yi;
                dy(2) = y1(1);
                hit = true;
                if cmd == 0
                    cmx = xi;
                    cmy = yi;
                    cmd = lengthOfLine(dx, dy);
                    mirrorStartEnd(1) = x2(1);
                    mirrorStartEnd(2) = y2(1);
                    mirrorStartEnd(3) = x2(2);
                    mirrorStartEnd(4) = y2(2);
                    cmid = idx;
                else
                    %work out the line length and chose the smallest line
                    
                    dist = lengthOfLine(dx, dy);
                    if dist < cmd
                        cmx = xi;
                        cmy = yi;
                        cmd = dist;
                        cmid = idx;
                        mirrorStartEnd(1) = x2(1);
                        mirrorStartEnd(2) = y2(1);
                        mirrorStartEnd(3) = x2(2);
                        mirrorStartEnd(4) = y2(2);
                    end
                end

                end
            end
        if not(isempty(cmx))
             display('here is cmx')
                cmx
            newx(2) = cmx;
            newx(1) = x1(1);
            newy(2) = cmy;
            newy(1) = y1(1);
            hit = true;
            mirrorx(1) = mirrorStartEnd(1);
            mirrorx(2) = mirrorStartEnd(3);
            mirrory(1) = mirrorStartEnd(2);
            mirrory(2) = mirrorStartEnd(4);
        else
            newx = x1;
            newy = y1;
            hit = false;
        end
else
   newx = x1;
   newy = y1;
   hit = false;
   cmid=0;
   anglenew = 0;
end
    
function [xi, yi] = findIntercept(x1, y1, x2, y2, idx)
xi = [];
yi = [];
global currentmirror;
currentmirror 
idx
global hitcounter
hitcounter
if currentmirror == 0
    [xi ,yi] = polyxpoly(x1, y1, x2, y2);
    
    if not(isempty(xi))
        currentmirror = idx;
    end
else
    if (hitcounter > 0) 
        if (currentmirror == idx)
        display('same')
        end
    end
   
end



function angleValue_Callback(hObject, eventdata, handles)
% hObject    handle to angleValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of angleValue as text
%        str2double(get(hObject,'String')) returns contents of angleValue as a double

%change the slider value too
thisBox = hObject;
currentValue = str2num(get(thisBox, 'String'));
handles.angleSlider.Value = currentValue;
redraw(handles);

function angle = findingTheAngle(x1,y1, x2,y2,x3, y3)
%v.w = ||v||.||w|| cos(pheta)
vw = ((x2-x1)*(x3-x1)) + ((y2-y1)*(y3-y1));
modV= sqrt((x2-x1)^2 + (y2-y1)^2);
modW=sqrt((x3-x1)^2 + (y3-y1)^2);
angle = acosd( vw/(modV*modW));

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

listAllMirrors




function x1_Callback(hObject, eventdata, handles)
% hObject    handle to x1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x1 as text
%        str2double(get(hObject,'String')) returns contents of x1 as a double


% --- Executes during object creation, after setting all properties.
function x1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y1_Callback(hObject, eventdata, handles)
% hObject    handle to y1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y1 as text
%        str2double(get(hObject,'String')) returns contents of y1 as a double


% --- Executes during object creation, after setting all properties.
function y1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x2_Callback(hObject, eventdata, handles)
% hObject    handle to x2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x2 as text
%        str2double(get(hObject,'String')) returns contents of x2 as a double


% --- Executes during object creation, after setting all properties.
function x2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y2_Callback(hObject, eventdata, handles)
% hObject    handle to y2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y2 as text
%        str2double(get(hObject,'String')) returns contents of y2 as a double


% --- Executes during object creation, after setting all properties.
function y2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in AddMirror.
function AddMirror_Callback(hObject, eventdata, handles)
% hObject    handle to AddMirror (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
thisMirrorCounter = get_mirrorCounter;
thisMirror = Mirror(get_mirrorCounter);
inc_mirrorCounter();

[x, y] = ginput(2)

set_mirrorArrayKey(thisMirror.update(x, y), thisMirrorCounter);

redraw(handles);

function deleteMirror(mirrorNumber)
am = get_mirrorArray;
thisMirror = am(mirrorNumber);
set_mirrorArrayKey(thisMirror.updateDel(1), mirrorNumber);

function listAllMirrors()
am = get_mirrorArray;
for idx = 1:numel(am)
    element = am(idx)
    ....
end



function [x, y] = getMirrorValues(mirrorNumber)
am = get_mirrorArray;
thisMirror = am(mirrorNumber);
[x, y] = thisMirror.getValues;

function plotMirrors()
hold on

am = get_mirrorArray;
for idx = 1:numel(am)
    [x, y] = getMirrorValues(idx);
    plot(x, y);
    ....
end




function redraw(handles)
plotPoint(handles);
global mirrorCounter;
if mirrorCounter > 1
    plotMirrors;
end


function inc_mirrorCounter()
global mirrorCounter;
mirrorCounter = mirrorCounter + 1;

function dec_mirrorCounter()
global mirrorCounter;
mirrorCounter = mirrorCounter -1;

function x = get_mirrorCounter
global mirrorCounter;
x = mirrorCounter;

function x = get_mirrorArray
global mirrorArray;
x = mirrorArray;

function set_mirrorArrayKey(value, key)
global mirrorArray;
mirrorArray(key) = value;

function ini_mirrorArray()
global mirrorArray;
x = zeros(1);
mirrorArray = Mirror(x);



function delMirrorValue_Callback(hObject, eventdata, handles)
% hObject    handle to delMirrorValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of delMirrorValue as text
%        str2double(get(hObject,'String')) returns contents of delMirrorValue as a double


% --- Executes during object creation, after setting all properties.
function delMirrorValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to delMirrorValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in delMirrorButton.
function delMirrorButton_Callback(hObject, eventdata, handles)
% hObject    handle to delMirrorButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
deleteMirror(str2num(handles.delMirrorValue.String));
plotMirrors();
