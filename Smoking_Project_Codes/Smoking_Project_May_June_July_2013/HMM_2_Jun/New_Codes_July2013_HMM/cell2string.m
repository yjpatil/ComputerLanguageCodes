function cellstring = cell2string(var)
%CELL2STRING get the sentence which the input cell variable created
%   cellstring = cell2string(var) get the sentence which var created
%   the input variable var must be a cell, which contains double, int,
%   int16, int32, int64, int8, logical, uint16, uint32, uint64, uint8, char
%   
%   Example:
%     demo = {true,1,{'a',int16(12)}}
%   See also STRUCT2STRING.

%   Copyright 2012-2020 Xibiao Studio
%   Author: Xiaobiao Huang
%   $Revision: 1.0.0.1 Date: $ 2012-12-20 22:02 $

if ~iscell(var)
    disp('Error: the intput variable is not a cell')
    return;
end
cellstring = [];
[f,v] = size(var);
for i=1:f
     for j=1:v
        cellstring = handlecell(cellstring,var{i,j},v,f,j,i);
        if j ~= v
            cellstring = [ cellstring ','];
        end       
     end
end

function [cellstring] = handlecell(cellstring,var,cv,cf,cfPointer,cvPointer)
if ~iscell(var)
    if cfPointer == 1 && cvPointer == 1
        if ~ischar(var)
            if islogical(var)
                if var
                    cellstring = [cellstring '{true'];
                else
                    cellstring = [cellstring '{false'];
                end
            else
                vartype = class(var);
                cellstring = [cellstring '{' vartype '(' num2str(var) ')'];
            end
        else
            cellstring = [cellstring '{''' var ''''];
        end
    else
        if ~ischar(var)
            if islogical(var)
                if var
                    cellstring = [cellstring 'true'];
                else
                    cellstring = [cellstring 'false'];
                end
            else
                vartype = class(var);
                cellstring = [cellstring vartype '(' num2str(var) ')'];
            end            
        else
            if strfind(var, ' ')
                cellstring = [cellstring '[''' var ''']'];
            else
                cellstring = [cellstring '''' var ''''];
            end
        end
    end
else
    if cfPointer == 1 && cvPointer == 1
        cellstring = [cellstring '{'];
    end
    [f,v] = size(var);
    for i=1:f
        for j=1:v
            cellstring = handlecell(cellstring,var{i,j},v,f,j,i);
            if j ~= v
                cellstring = [ cellstring ','];
            end
        end
    end
end
if cvPointer == cf && cfPointer == cv
    cellstring = [cellstring '}'];
end
if cv == 1
    if cf > 1 && cfPointer ~= cf && cvPointer ~= cf
        cellstring = [ cellstring ';'];
    end
else
    if cf > 1 && cvPointer == cv && cfPointer ~= cf
        cellstring = [ cellstring ';'];
    end
end
